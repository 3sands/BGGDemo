//
//  File.swift
//  
//
//  Created by Trey on 11/10/23.
//

import BGGDemoUtilities
import SwiftUI

// View for the Board Game Title
public struct BoardGameTitleView: View {
    public init(_ game: BoardGame) {
        self.game = game
    }
    
    public var body: some View {
        VStack {
            Text(game.mainTitle)
                .font(.headline)
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
    
    private let game: BoardGame
}

#Preview {
    BoardGameTitleView(previewBoardGame)
}
