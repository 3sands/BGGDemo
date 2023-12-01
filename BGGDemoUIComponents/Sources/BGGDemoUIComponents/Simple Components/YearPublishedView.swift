//
//  YearPublishedView.swift
//
//
//  Created by Trey on 12/1/23.
//

import BGGDemoUtilities
import SwiftUI

public protocol HasYearPublished {
    var yearPublished: Int? { get }
}

public struct YearPublishedView: View {
    public var body: some View {
        if let yearPublished = game.yearPublished {
            Label(String(yearPublished), systemImage:"calendar")
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
    
    public init(_ game: HasYearPublished) {
        self.game = game
    }
    
    private let game: HasYearPublished
}

extension BoardGame: HasYearPublished { }

extension UserCollectionBoardGame: HasYearPublished { }

#Preview {
    YearPublishedView(previewBoardGame)
}
