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
    @StateObject var viewModel: BGGSearchViewModel

    var body: some View {
        NavigationStack {
            switch viewModel.boardGameResults {
            case .noResults:
                Text("Searching for \(viewModel.searchTerm)")
                
            case .results(let array):
                // Add a way to filter on the results locally here
                Text("Results: \(array.count)")
                List(array) {
                    switch $0 {
                    case .boardGame(let game):
                        NavigationLink(
                            destination: TempView(game: game,
                                                  repo: viewModel.repo)
                        ) {
                            BoardGameSearchResultCell(game)
                        }
                    default:
                        Text("NOOOPE")
                    }
                }
                .ignoresSafeArea()
            case .error:
                Text("Error")
            }
        }
        .navigationTitle("BGGDemo")
            .searchable(text: $viewModel.searchTerm)
    }
}

#Preview {
    let container = try! ModelContainer(for: Item.self, configurations: .init(for: Item.self, isStoredInMemoryOnly: true))
    return BGGSearchView(viewModel: BGGSearchViewModel(initialData: previewBGGThings, repo: .init(modelContext: container.mainContext)))
//        .modelContainer(for: Item.self, inMemory: true)
}
