//
//  SwiftUIView.swift
//
//
//  Created by Trey on 10/26/23.
//

import BGGDemoUtilities
import SwiftUI

let previewBoardGame = BoardGame(id: 123456,
                                 titles: ["Agricola", "Agricoli"],
                                 mainTitle: "Agricola")


public struct BoardGameSearchResultCell: View {
    private let game: BoardGame
    
    public var body: some View {
        VStack {
            Text(String(game.id))
            Text(game.mainTitle)
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
