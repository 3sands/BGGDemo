//
//  BGGUserCollectionView.swift
//  BGGDemo
//
//  Created by Trey on 11/29/23.
//

import Combine
import SwiftUI
import SwiftData
import BGGDemoRepositories
import BGGDemoUtilities
import BGGDemoUIComponents

struct BGGUserCollectionView: View {
    @StateObject var viewModel: BGGUserCollectionViewModel

    var body: some View {
        NavigationStack {
            switch viewModel.collectionResults {
            case .noResults:
                Text("No collection for the username \(viewModel.userName)")
                
            case .results(let array):
                // TODO: Add a way to filter on the results locally here
                Text("Results: \(array.collection.count)")
                List(array.collection) {
                    switch $0 {
                    case .boardGame(let game):
                        // TODO: update navigation
                        NavigationLink(
                            destination: BoardGameDetailView(gameID: game.bggId,
                                                             repo: viewModel.repo)
                        ) {
                            // TODO: Check for accessibility
                            UserCollectionCell(game)
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
        .navigationTitle("User Collection")
        .searchable(text: $viewModel.userName)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
    }
}

#Preview {
    let container = try! ModelContainer(for: BoardGameDataObject.self, configurations: .init(for: BoardGameDataObject.self, isStoredInMemoryOnly: true))
    return BGGUserCollectionView(viewModel: BGGUserCollectionViewModel(initialData: previewUserCollection, repo: BGGDemoRepositories(modelContext: container.mainContext)))
}
