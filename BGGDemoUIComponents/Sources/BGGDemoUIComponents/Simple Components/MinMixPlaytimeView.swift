//
//  MinMixPlaytimeView.swift
//
//
//  Created by Trey on 11/8/23.
//

import BGGDemoUtilities
import SwiftUI

public protocol HasMinMaxPlaytime {
    var minPlaytime: Int? { get }
    var maxPlaytime: Int? { get }
}

// View for the Min-max playtime with clock icon
public struct MinMixPlaytimeView: View {
    public var body: some View {
        if let labelText {
            Label(labelText, systemImage: "clock")
                .font(.caption)
                .foregroundStyle(.primary)
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
    
    public init(_ game: HasMinMaxPlaytime) {
        self.game = game
    }
    
    private let game: HasMinMaxPlaytime
    private var labelText: String? {
        if let minPlaytime = game.minPlaytime,
           let maxPlaytime = game.maxPlaytime {
            return "\(minPlaytime) - \(maxPlaytime)"
        } else if let minPlaytime = game.minPlaytime {
            return "\(minPlaytime)"
        } else if let maxPlaytime = game.maxPlaytime {
            return "\(maxPlaytime)"
        } else {
            return nil
        }
    }
}

extension BoardGame: HasMinMaxPlaytime { }

#Preview {
    MinMixPlaytimeView(previewBoardGame)
}
