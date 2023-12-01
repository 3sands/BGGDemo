//
//  UserCollectionGameStatusesView.swift
//
//
//  Created by Trey on 11/30/23.
//

import BGGDemoUtilities
import SwiftUI

public protocol HasGameStatuses {
    var statuses: Set<UserCollectionGameStatus> { get }
}

public struct UserCollectionGameStatusesView: View {
    public var body: some View {
        if !game.statuses.isEmpty {
            LazyVGrid(columns: columns, content: {
                ForEach(game.statuses.sorted { $0.id < $1.id }) { status in
                    StatusTextView(status.displayString)
                }
            })
            .padding(3)
            .background(RoundedRectangle(cornerRadius: 6)
                .fill(Color.khaki)
                .shadow(radius: 3)
            )
        }
    }
    
    public init(_ game: HasGameStatuses,
                numberOfColumns: Int) {
        self.game = game
        self.numberOfColumns = numberOfColumns
    }
    
    private struct StatusTextView: View {
        var body: some View {
            Text(text)
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
        
        init(_ text: String) {
            self.text = text
        }
        
        private let text: String
    }
    
    private let game: HasGameStatuses
    private let numberOfColumns: Int
    private var columns: [GridItem] {
        (0..<numberOfColumns).map { _ in GridItem(.flexible(), alignment: .leading) }
    }
}

extension UserCollectionBoardGame: HasGameStatuses { }

#Preview {
    UserCollectionGameStatusesView(previewUserCollectionBoardGame,
                                   numberOfColumns: 2)
}
