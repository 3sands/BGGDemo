//
//  PlayersNumberView.swift
//
//
//  Created by Trey on 11/8/23.
//

import SwiftUI
import BGGDemoUtilities

public protocol ContainsPlayersNumber {
    var minPlayers: Int? { get }
    var maxPlayers: Int? { get }
}

// View for the Min-max players number with person icon
public struct PlayersNumberView: View {
    public var body: some View {
        if let labelText {
            Label(labelText, systemImage: "person")
                .foregroundStyle(.primary)
                .font(.caption)
                .padding(EdgeInsets(top: 1,
                                    leading: 3,
                                    bottom: 1,
                                    trailing: 6))
                .background(RoundedRectangle(cornerRadius: 6)
                    .fill(Color.lightKhaki)
                    .shadow(radius: 3)
                )
        }
    }
    
    public init(_ game: BoardGame) {
        self.game = game
    }
    
    private let game: BoardGame
    private var labelText: String? {
        if let minPlayers = game.minPlayers,
           let maxPlayers = game.maxPlayers {
            // Don't need to show unnecessary hyphen if there's only 1 number of players allowed
            guard minPlayers != maxPlayers else {
                return "\(minPlayers)"
            }

            return "\(minPlayers) - \(maxPlayers)"
        } else if let minPlayers = game.minPlayers {
            return "\(minPlayers)"
        } else if let maxPlayers = game.maxPlayers {
            return "\(maxPlayers)"
        } else {
            return nil
        }
    }
}

extension BoardGame: ContainsPlayersNumber { }

#Preview {
    PlayersNumberView(previewBoardGame)
}
