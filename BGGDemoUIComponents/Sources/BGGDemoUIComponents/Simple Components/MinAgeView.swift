//
//  MinAgeView.swift
//
//
//  Created by Trey on 11/9/23.
//

import BGGDemoUtilities
import SwiftUI

public protocol HasMinAge {
    var minAge: Int? { get }
}

// View for the minimum age with adult-child icon
public struct MinAgeView: View {
    public init(_ game: HasMinAge) {
        self.game = game
    }
    
    public var body: some View {
        if let minAge = game.minAge {
            Label("\(minAge)+", systemImage: "figure.and.child.holdinghands")
                .padding(EdgeInsets(top: 1,
                                    leading: 3,
                                    bottom: 1,
                                    trailing: 6))
                .font(.caption)
                .foregroundStyle(.primary)
                .background(RoundedRectangle(cornerRadius: 6)
                    .fill(Color.lightKhaki)
                    .shadow(radius: 3)
                )
        }
    }
    
    private let game: HasMinAge
}

extension BoardGame: HasMinAge { }

#Preview {
    MinAgeView(previewBoardGame)
}
