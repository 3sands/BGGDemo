//
//  BGGSearchView.swift
//  BGGDemo
//
//  Created by Trey on 10/24/23.
//

import Combine
import SwiftUI
import SwiftData
import BGGDemoRepositiories
import BGGDemoUtilities
import BGGDemoUIComponents

extension Publisher {
    func asyncMap<T>(
        _ transform: @escaping (Output) async -> T
    ) -> Publishers.FlatMap<Future<T, Never>, Self> {
        flatMap { value in
            Future { promise in
                Task {
                    let output = await transform(value)
                    promise(.success(output))
                }
            }
        }
    }
}

extension Future where Failure == Error {
    convenience init(operation: @escaping () async throws -> Output) {
        self.init { promise in
            Task {
                do {
                    let output = try await operation()
                    promise(.success(output))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
}

struct BGGSearchView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel: BGGSearchViewModel

    var body: some View {
        NavigationStack {
            switch viewModel.boardGameResults {
            case .noResults:
                Text("Searching for \(viewModel.searchTerm)")
                
            case .results(let array):
                Text("results are \(array.count)")
                VStack {
                    ForEach(array) { thing in
                        switch thing {
                        case .boardGame(let game):
                            BoardGameSearchResultCell(game)
                        default:
                            Text("NOOOPE")
                        }
                    }
                }
                Spacer()
            case .error:
                Text("Error")
            }
        }
        .navigationTitle("BGGDemo")
            .searchable(text: $viewModel.searchTerm)
    }
}

#Preview {
    BGGSearchView(viewModel: BGGSearchViewModel(initialData: previewBGGThings))
        .modelContainer(for: Item.self, inMemory: true)
}
