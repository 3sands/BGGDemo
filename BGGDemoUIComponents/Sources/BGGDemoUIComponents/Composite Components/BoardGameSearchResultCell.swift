//
//  BoardGameSearchResultCell.swift
//
//
//  Created by Trey on 10/26/23.
//

import BGGDemoUtilities
import SwiftUI

// View for the Board Game Search Result Cell
public struct BoardGameSearchResultCell: View {
    public var body: some View {
        HStack {
            ThumbnailImageView(game)
            
            VStack(alignment: .leading) {
                BoardGameTitleView(game)
                
                HStack {
                    PlayersNumberView(game)
                    MinAgeView(game)
                }
                
                HStack {
                    MinMixPlaytimeView(game)
                    AverageCommunityRatingView(game)
                }
            }
            
            Spacer()
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(.brown, lineWidth: 4)
        )
        .background(Color.khaki)
    }
    
    public init(_ game: BoardGame) {
        self.game = game
    }
    
    private let game: BoardGame
}

#Preview {
    BoardGameSearchResultCell(previewBoardGame)
}
