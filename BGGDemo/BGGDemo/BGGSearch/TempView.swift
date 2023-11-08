//
//  TempView.swift
//  BGGDemo
//
//  Created by Trey on 10/27/23.
//

import SwiftUI
import BGGDemoRepositiories
import BGGDemoUtilities
import SwiftData

struct TempView: View {
    let game: BoardGame
    let repo: BGGDemoRepositiories
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init(game: BoardGame, repo: BGGDemoRepositiories) {
        self.game = game
        self.repo = repo
    }
}

#Preview {
    let container = try! ModelContainer(for: Item.self, configurations: .init(for: Item.self, isStoredInMemoryOnly: true))
    return TempView(game: previewBoardGame,
                    repo: .init(modelContext: container.mainContext))
}
