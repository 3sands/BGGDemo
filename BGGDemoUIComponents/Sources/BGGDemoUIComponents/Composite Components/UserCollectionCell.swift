//
//  UserCollectionCell.swift
//
//
//  Created by Trey on 11/30/23.
//

import BGGDemoUtilities
import SwiftUI

// View for the Board Game Search Result Cell
public struct UserCollectionCell: View {
    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                thumbnailHeaderView
                
                UserCollectionGameStatusesView(game,
                                               numberOfColumns: 3)
                
                UserCollectionBoardGameCommentView(game)
            }
            
            Spacer()
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(.brown, lineWidth: 4)
        )
        .background(Color.khaki)
    }
    
    public init(_ game: UserCollectionBoardGame) {
        self.game = game
    }
    
    private var thumbnailHeaderView: some View {
        HStack(alignment: .center) {
            ThumbnailImageView(game)
            
            VStack(alignment: .leading) {
                BoardGameTitleView(game)
                NumberOfPlaysView(game)
                UserRatingView(game)
                AverageCommunityRatingView(game)
                YearPublishedView(game)
            }
        }
    }
    
    private let game: UserCollectionBoardGame
}

#Preview {
    UserCollectionCell(previewUserCollectionBoardGame)
}
