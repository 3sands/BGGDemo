//
//  UserRatingView.swift
//
//
//  Created by Trey on 11/30/23.
//

import SwiftUI
import BGGDemoUtilities

public protocol HasUserRating {
    var userRating: Float? { get }
}

// View for the User Rating with the sum
public struct UserRatingView: View {
    public var body: some View {
        if let userRating = game.userRating {
            Label(String(format: "%.1f", userRating), systemImage:"hand.thumbsup")
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
    
    public init(_ game: HasUserRating) {
        self.game = game
    }
    
    private let game: HasUserRating
}

extension UserCollectionBoardGame: HasUserRating { }

#Preview {
    UserRatingView(previewUserCollectionBoardGame)
}
