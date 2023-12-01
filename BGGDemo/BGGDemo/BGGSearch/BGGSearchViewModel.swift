//
//  BGGSearchViewModel.swift
//  BGGDemo
//
//  Created by Trey on 10/26/23.
//

import Combine
import Foundation
import SwiftData
import BGGDemoRepositories
import BGGDemoUtilities
import BGGDemoUIComponents

let previewBGGThings: [BGGThing] = [.boardGame(previewBoardGame)]

@MainActor
class BGGSearchViewModel: ObservableObject {
    let repo: BGGDemoRepositoryService
    // input
    @Published var searchTerm: String = ""
    
    // output
    @Published private(set) var boardGameResults: SearchState = .emptySearchTerm
    
    enum SearchState {
        case noResults
        case emptySearchTerm
        case results([BGGThing])
        case error(Error)
    }

    init(initialData: [BGGThing]? = nil,
         repo: BGGDemoRepositoryService) {
        self.repo = repo
        
        setupSearchForGamesAfterSearchTermInputChanges()
        initializeSearchView(from: initialData)
    }
    
    /// Binds searching for games after the search input changes to the board game results publisher
    private func setupSearchForGamesAfterSearchTermInputChanges() {
        $searchTerm
            .debounce(for: .milliseconds(300),
                      scheduler: DispatchQueue.main)
            .removeDuplicates()
            .flatMap { query -> Future<SearchState, Never> in
                Future { promise in
                    Task {
                        do {
                            guard query.isNotEmpty else {
                                promise(.success(.emptySearchTerm))
                                return
                            }

                            let result = try await self.repo.bggItems(from: .boardGame,
                                                                      forSearchQuery: query,
                                                                      withStats: true)
                            guard result.isNotEmpty else {
                                promise(.success(.noResults))
                                return
                            }
                            
                            promise(.success(.results(result)))
                        } catch {
                            promise(.success(.error(error)))
                        }
                    }
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .assign(to: &$boardGameResults)
    }
    
    /// Initializes the search view with any cached search result
    /// - Parameter cachedData: initial cached board games search results
    private func initializeSearchView(from cachedData: [BGGThing]?) {
        if let cachedData {
            Just(SearchState.results(cachedData))
                .assign(to: &$boardGameResults)
        }
    }
}
