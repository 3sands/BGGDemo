//
//  BoardGameDetailView.swift
//  BGGDemo
//
//  Created by Trey on 10/27/23.
//

import Combine
import SwiftUI
import BGGDemoRepositories
import BGGDemoUtilities
import BGGDemoUIComponents
import SwiftData

// View for a board game detail
struct BoardGameDetailView: View {
    var body: some View {
        switch viewModel.displayType {
        case .noData:
            // TODO
            Text("No data available")
        case .error(let error):
            // TODO
            Text(error.localizedDescription)
        case .game(let game):
            ScrollView {
                BoardGameDetailTitleView(game)
                
                HStack {
                    BoardGameDetailCoverView(game)
                    
                    VStack(alignment: .leading) {
                        PlayersNumberView(game)
                        MinAgeView(game)
                        MinMixPlaytimeView(game)
                        AverageCommunityRatingView(game)
                    }
                    .padding()
                }
                
                BoardGameDetailDescriptionView(game)
                
                // TODO: add in other stats that are available
                // TODO: add in a button to "show more" to make a new call to bgg api
                // to get the extra details
                
                // TODO: Add in link to bgg website itself
                // TODO: add in a share button to share the game's ID with another user?
                // TODO: Add button to show statistics using SwiftUI's graph view and the available stats for the user polls on age and language dependency and number of players
                // TODO: Show other titles

                Spacer()
            }
            .background(Color.khaki)
        }
    }
    
    init(game: BoardGame,
         repo: BGGDemoRepositoryService) {
        _viewModel = .init(wrappedValue: BoardGameDetailViewModel(gameID: game.id,
                                                                      repo: repo))
    }
    
    init(gameID: Int,
         repo: BGGDemoRepositoryService) {
        _viewModel = .init(wrappedValue: BoardGameDetailViewModel(gameID: gameID,
                                                                      repo: repo))
    }
    
    @StateObject private var viewModel: BoardGameDetailViewModel
}

#Preview {
    let container = try! ModelContainer(for: BoardGameDataObject.self, 
                                        BoardGameExpansionDataObject.self,
                                        configurations: .init(for:
                                                                BoardGameDataObject.self,
                                                              BoardGameExpansionDataObject.self,
                                                              isStoredInMemoryOnly: true))
    let boardGame = BoardGameDataObject(game: previewBoardGame)
    container.mainContext.insert(boardGame)
    try? container.mainContext.save()
    
    return BoardGameDetailView(game: previewBoardGame,
                               repo: BGGDemoRepositories(modelContext: container.mainContext))
}
