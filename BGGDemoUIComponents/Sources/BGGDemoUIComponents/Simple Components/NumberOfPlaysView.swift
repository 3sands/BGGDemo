//
//  NumberOfPlaysView.swift
//
//
//  Created by Trey on 11/30/23.
//

import SwiftUI
import BGGDemoUtilities

public protocol HasNumberOfPlays {
    var numPlays: Int? { get }
}

// View for the number of plays with the sum
public struct NumberOfPlaysView: View {
    public init(_ game: HasNumberOfPlays) {
        self.game = game
    }
    
    public var body: some View {
        if let numPlays = game.numPlays {
            Label("\(numPlays)", systemImage: "sum")
                .foregroundStyle(.primary)
                .font(.caption)
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
    
    private let game: HasNumberOfPlays
}

extension UserCollectionBoardGame: HasNumberOfPlays { }

#Preview {
    NumberOfPlaysView(previewUserCollectionBoardGame)
}
