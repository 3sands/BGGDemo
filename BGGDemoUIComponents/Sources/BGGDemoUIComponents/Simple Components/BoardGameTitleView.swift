//
//  BoardGameTitleView.swift
//
//
//  Created by Trey on 11/10/23.
//

import BGGDemoUtilities
import SwiftUI

public protocol ContainsTitle {
    var title: String { get }
}

// View for the Board Game Title
public struct BoardGameTitleView: View {
    public var body: some View {
        Text(game.title)
            .font(.headline)
            .padding(EdgeInsets(top: 1,
                                leading: 3,
                                bottom: 1,
                                trailing: 6))
            .background(RoundedRectangle(cornerRadius: 6)
                .fill(Color.lightKhaki)
                .shadow(radius: 3)
            )
    }
    
    public init(_ game: ContainsTitle) {
        self.game = game
    }
    
    private let game: ContainsTitle
}

extension BoardGame: ContainsTitle {
    public var title: String { mainTitle }
}

extension UserCollectionBoardGame: ContainsTitle {
    public var title: String { name }
}

#Preview {
    BoardGameTitleView(previewBoardGame)
}
