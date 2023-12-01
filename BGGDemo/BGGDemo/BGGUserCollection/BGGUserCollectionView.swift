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
    var body: some View {
        NavigationStack {
            switch viewModel.collectionResults {
            case .noResults:
                Text("No collection for the username \(viewModel.userName)")
                
            case .results(let array):
                // TODO: Add a way to filter on the results locally here
                // TODO: add in toggle for list vs grid display
                // TODO: Add in a refresh button for user collection to get updated from website
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
        // TODO: customize the search bar and nav bar to look nice
        .navigationTitle("User Collection")
        .searchable(text: $viewModel.userName)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
    }
    
    init(initialData: UserCollection? = nil,
         repo: BGGDemoRepositoryService) {
        _viewModel = .init(wrappedValue: BGGUserCollectionViewModel(initialData: initialData,
                                                                      repo: repo))

    }
    
    @StateObject private var viewModel: BGGUserCollectionViewModel
}

#Preview {
    let container = try! ModelContainer(for: BoardGameDataObject.self, configurations: .init(for: BoardGameDataObject.self, isStoredInMemoryOnly: true))
    return BGGUserCollectionView(initialData: previewUserCollection, repo: BGGDemoRepositories(modelContext: container.mainContext))
}
