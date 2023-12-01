//
//  BoardGameDetailTitleView.swift
//  
//
//  Created by Trey on 11/29/23.
//

import SwiftUI
import BGGDemoUtilities

// View for the Board Game Detail's Title
public struct BoardGameDetailTitleView: View {
    public var body: some View {
        Text(game.mainTitle)
            .font(.title)
            .padding()
            .background(RoundedRectangle(cornerRadius: 4)
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
    BoardGameDetailTitleView(previewBoardGame)
}
