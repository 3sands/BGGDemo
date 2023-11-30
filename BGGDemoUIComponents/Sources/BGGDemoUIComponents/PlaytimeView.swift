//
//  SwiftUIView.swift
//  
//
//  Created by Trey on 11/8/23.
//

import BGGDemoUtilities
import SwiftUI

// View for the Min-max playtime with clock icon
public struct PlaytimeView: View {
    public var body: some View {
        VStack {
            if let minPlaytime = game.minPlaytime,
               let maxPlaytime = game.maxPlaytime {
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                    Text("\(minPlaytime) - \(maxPlaytime)")
                }
            } else if let minPlaytime = game.minPlaytime {
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                    Text("\(minPlaytime)")
                }
            } else if let maxPlaytime = game.maxPlaytime {
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                    Text("\(maxPlaytime)")
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
    PlaytimeView(previewBoardGame)
}
