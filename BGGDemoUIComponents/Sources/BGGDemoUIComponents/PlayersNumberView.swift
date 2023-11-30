//
//  SwiftUIView.swift
//  
//
//  Created by Trey on 11/8/23.
//

import SwiftUI
import BGGDemoUtilities

// View for the Min-max players number with person icon
public struct PlayersNumberView: View {
    public var body: some View {
        VStack {
            if let minPlayers = game.minPlayers,
               let maxPlayers = game.maxPlayers {
                HStack(spacing: 4) {
                    Image(systemName: "person")
                    Text("\(minPlayers) - \(maxPlayers)")
                }
            } else if let minPlayers = game.minPlayers {
                HStack(spacing: 4) {
                    Image(systemName: "person")
                    Text("\(minPlayers)")
                }
            } else if let maxPlayers = game.maxPlayers {
                HStack(spacing: 4) {
                    Image(systemName: "person")
                    Text("\(maxPlayers)")
                }
            }
        }
        .padding(EdgeInsets(top: 1,
                            leading: 3,
                            bottom: 1,
                            trailing: 6))
        .background(RoundedRectangle(cornerRadius: 6)
            .fill(Color.lightKhaki)
            .shadow(radius: 3)
        )
    }
    
    public init(_ game: BoardGame) {
        self.game = game
    }
    
    private let game: BoardGame
}

#Preview {
    PlayersNumberView(previewBoardGame)
}
