//
//  SwiftUIView.swift
//  
//
//  Created by Trey on 11/8/23.
//

import BGGDemoUtilities
import SwiftUI

// View for the Average Rating with laurel icons
public struct AverageRatingView: View {
    public var body: some View {
        VStack {
            if let averageRating = game.averageRating {
                HStack(spacing: 0) {
                    Image(systemName: "laurel.leading")
                    Text(String(format: "%.2f", averageRating))
                    Image(systemName: "laurel.trailing")
                }
            }
        }
        .padding(EdgeInsets(top: 1,
                            leading: 3,
                            bottom: 1,
                            trailing: 3))
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
    AverageRatingView(previewBoardGame)
}
