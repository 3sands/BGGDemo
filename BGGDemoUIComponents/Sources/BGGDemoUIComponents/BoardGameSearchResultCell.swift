//
//  SwiftUIView.swift
//
//
//  Created by Trey on 10/26/23.
//

import BGGDemoUtilities
import SwiftUI

public struct BoardGameSearchResultCell: View {
    private let game: BoardGame
    
    public var body: some View {
        HStack {
            AsyncImage(url: URL(string: game.thumbnailURL ?? "")) { image in
                image.image?.resizable()
            }
                .frame(width: 80, height: 80)
            VStack(alignment: .leading) {
                Text(game.mainTitle)
                
                if let minPlayers = game.minPlayers,
                   let maxPlayers = game.maxPlayers {
                    Text("Players: \(minPlayers) - \(maxPlayers)")
                }
                
                if let minPlaytime = game.minPlaytime,
                   let maxPlaytime = game.maxPlaytime {
                    Text("Minutes of play: \(minPlaytime) - \(maxPlaytime)")
                }
                
                if let averageRating = game.averageRating {
                    Text(String(format: "Average Rating: %.2f", averageRating))
                }
            }
            
            Spacer()
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(.blue, lineWidth: 4)
        )
    }
    
    public init(_ game: BoardGame) {
        self.game = game
    }
}

#Preview {
    BoardGameSearchResultCell(previewBoardGame)
}
