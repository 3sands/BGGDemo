//
//  UserCollectionBoardGameCommentView.swift
//
//
//  Created by Trey on 11/30/23.
//

import BGGDemoUtilities
import SwiftUI

public protocol HasComment {
    var comment: String? { get }
}

// View for the User Colection Board Game's Comment View
public struct UserCollectionBoardGameCommentView: View {
    public var body: some View {
        if let comment = game.comment {
            Text(comment)
                .font(.caption)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4)
                    .fill(Color.lightKhaki)
                    .shadow(radius: 3)
                )
        }
    }
    
    public init(_ game: HasComment) {
        self.game = game
    }
    
    private let game: HasComment
}

extension UserCollectionBoardGame: HasComment { }

#Preview {
    UserCollectionBoardGameCommentView(previewUserCollectionBoardGame)
}
