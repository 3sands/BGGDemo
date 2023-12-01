//
//  AverageCommunityRatingView.swift
//  
//
//  Created by Trey on 11/8/23.
//

import BGGDemoUtilities
import SwiftUI

public protocol HasAverageCommunityRating {
    var averageCommunityRating: Float? { get }
}

// View for the Average Rating with laurel icons
public struct AverageCommunityRatingView: View {
    public var body: some View {
        if let averageRating = game.averageCommunityRating {
            HStack(spacing: 0) {
                Image(systemName: "laurel.leading")
                    .font(.caption)
                Text(String(format: "%.2f", averageRating))
                    .font(.caption)
                Image(systemName: "laurel.trailing")
                    .font(.caption)
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
    }
    
    public init(_ game: HasAverageCommunityRating) {
        self.game = game
    }
    
    private let game: HasAverageCommunityRating
}

extension BoardGame: HasAverageCommunityRating { }

extension UserCollectionBoardGame: HasAverageCommunityRating { }

#Preview {
    AverageCommunityRatingView(previewBoardGame)
}
