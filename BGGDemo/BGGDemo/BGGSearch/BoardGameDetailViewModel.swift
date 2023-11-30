//
//  BoardGameDetailViewViewModel.swift
//  BGGDemo
//
//  Created by Trey on 11/29/23.
//

import SwiftUI
import BGGDemoRepositories
import BGGDemoUtilities
import BGGDemoUIComponents

// View Model for a board game detail
@MainActor
class BoardGameDetailViewModel: ObservableObject {
    enum DisplayType {
        case noData
        case error(Error)
        case game(BoardGame)
    }
    
    @Published var displayType: DisplayType = .noData
    
    init(gameID: Int,
         repo: BGGDemoRepositoryService) {
        self.repo = repo
        self.gameID = gameID
        
        Task {
            await fetch()
        }
    }
    
    private func fetch() async {
        do {
            let awaitedGame = try await repo.bggItem(forId: gameID)?.boardGame
            if let awaitedGame {
                displayType = .game(awaitedGame)
            } else {
                displayType = .noData
            }
        } catch {
            displayType = .error(error)
        }
    }
    
    private let gameID: Int
    private let repo: BGGDemoRepositoryService
}
