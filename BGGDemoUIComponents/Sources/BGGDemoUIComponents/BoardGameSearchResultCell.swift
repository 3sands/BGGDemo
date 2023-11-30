//
//  SwiftUIView.swift
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
            AsyncImage(url: URL(string: game.thumbnailURL ?? "")) { image in
                image.image?.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
            }
            
            VStack(alignment: .leading) {
                BoardGameTitleView(game)
                
                HStack {
                    PlayersNumberView(game)
                    
                    MinAgeView(game)
                }
                
                HStack {
                    PlaytimeView(game)
                    AverageRatingView(game)
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
