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
            masterView
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .boardGameDetail(let gameID):
                        BoardGameDetailView(gameID: gameID, repo: viewModel.repo)
                    }
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
    
    private var masterView: some View {
        return VStack {
            switch viewModel.collectionResults {
            case .emptySearchTerm:
                Text("Enter a user name to view their collection")
                
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
                        
                        NavigationLink(value: Route.boardGameDetail(gameID: game.bggId)) {
                            // TODO: Check for accessibility
                            UserCollectionCell(game)
                        }
                        //                        NavigationLink(
                        //                            destination: BoardGameDetailView(gameID: game.bggId,
                        //                                                             repo: viewModel.repo)
                        //                        ) {
                        //                            // TODO: Check for accessibility
                        //                            UserCollectionCell(game)
                        //                        }
                    default:
                        Text("NOOOPE")
                    }
                }
                .listStyle(.plain)
                
            case .error(let error):
                if let customError = error as? CustomErrors {
                    Text("Error: \(customError.displayText)")
                } else {
                    Text("Unknown error occurred")
                }
            }
        }
    }
    
    @StateObject private var viewModel: BGGUserCollectionViewModel
}

#Preview {
    let container = try! ModelContainer(for: BoardGameDataObject.self, configurations: .init(for: BoardGameDataObject.self, isStoredInMemoryOnly: true))
    return BGGUserCollectionView(initialData: previewUserCollection, repo: BGGDemoRepositories(modelContext: container.mainContext))
}
