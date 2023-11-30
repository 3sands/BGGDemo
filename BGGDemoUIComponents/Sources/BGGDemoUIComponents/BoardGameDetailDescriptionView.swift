//
//  SwiftUIView.swift
//  
//
//  Created by Trey on 11/29/23.
//

import BGGDemoUtilities
import SwiftUI

// View for the Board Game Detail's Description View
public struct BoardGameDetailDescriptionView: View {
    public var body: some View {
        if let descriptionTextDecoded = game.descriptionTextDecoded {
            Text(descriptionTextDecoded)
                .font(.caption)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4)
                    .fill(Color.lightKhaki)
                    .shadow(radius: 3)
                )
                .padding()
        }
    }
    
    public init(_ game: BoardGame) {
        self.game = game
    }
    
    private let game: BoardGame
}

#Preview {
    BoardGameDetailDescriptionView(previewBoardGame)
}
