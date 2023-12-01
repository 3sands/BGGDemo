//
//  BoardGameDetailCoverView.swift
//  
//
//  Created by Trey on 11/29/23.
//

import SwiftUI
import BGGDemoUtilities

// View for the Board Game Detail's Cover
public struct BoardGameDetailCoverView: View {
    public var body: some View {
        AsyncImage(
            url: URL(string: game.imageURLString),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            },
            placeholder: {
                ProgressView()
            }
        )
        .padding()
    }
    
    public init(_ game: BoardGame) {
        self.game = game
    }
    
    private let game: BoardGame
}

#Preview {
    BoardGameDetailCoverView(previewBoardGame)
}
