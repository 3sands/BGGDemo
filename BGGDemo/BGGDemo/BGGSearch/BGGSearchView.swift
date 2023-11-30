//
//  BGGSearchView.swift
//  BGGDemo
//
//  Created by Trey on 10/24/23.
//

import Combine
import SwiftUI
import SwiftData
import BGGDemoRepositories
import BGGDemoUtilities
import BGGDemoUIComponents

struct BGGSearchView: View {
    @StateObject var viewModel: BGGSearchViewModel

    var body: some View {
        NavigationStack {
            switch viewModel.boardGameResults {
            case .noResults:
                Text("Searching for \(viewModel.searchTerm) resulted in no results")
                
            case .results(let array):
                // TODO: Add a way to filter on the results locally here
                Text("Results: \(array.count)")
                List(array) {
                    switch $0 {
                    case .boardGame(let game):
                        // TODO: update navigation
                        NavigationLink(
                            destination: BoardGameDetailView(gameID: game.id,
                                                             repo: viewModel.repo)
                        ) {
                            // TODO: Check for accessibility
                            BoardGameSearchResultCell(game)
                        }
                    default:
                        Text("NOOOPE")
                    }
                }
                .listStyle(.plain)
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
    return BGGSearchView(viewModel: BGGSearchViewModel(initialData: previewBGGThings, repo: BGGDemoRepositories(modelContext: container.mainContext)))
}
