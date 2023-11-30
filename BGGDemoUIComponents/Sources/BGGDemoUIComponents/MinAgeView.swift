//
//  SwiftUIView.swift
//  
//
//  Created by Trey on 11/9/23.
//

import BGGDemoUtilities
import SwiftUI

// View for the minimum age with adult-child icon
public struct MinAgeView: View {
    public init(_ game: BoardGame) {
        self.game = game
    }
    
    public var body: some View {
        VStack {
            if let minAge = game.minAge {
                HStack(spacing: 4) {
                    Image(systemName: "figure.and.child.holdinghands")
                    Text("\(minAge)+")
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
    
    private let game: BoardGame
}

#Preview {
    MinAgeView(previewBoardGame)
}
