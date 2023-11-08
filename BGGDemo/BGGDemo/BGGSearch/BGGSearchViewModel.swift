//
//  BGGSearchViewModel.swift
//  BGGDemo
//
//  Created by Trey on 10/26/23.
//

import Combine
import Foundation
import SwiftData
import BGGDemoRepositiories
import BGGDemoUtilities
import BGGDemoUIComponents

let previewBGGThings: [BGGThing] = [.boardGame(previewBoardGame)]

@MainActor
class BGGSearchViewModel: ObservableObject {
    let repo: BGGDemoRepositiories
    // input
    @Published var searchTerm: String = ""
    
    // output
    @Published private(set) var boardGameResults: SearchState = .noResults
    
    enum SearchState {
        case noResults
        case results([BGGThing])
        case error
    }

    init(initialData: [BGGThing]? = nil,
         repo: BGGDemoRepositiories) {
        self.repo = repo
        
        $searchTerm
            .debounce(for: .milliseconds(300),
                      scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .flatMap { query -> Future<[BGGThing], Never> in
                Future { promise in
                    Task {
                        do {
                            let result = try await self.repo.bggItems(from: .boardGame, 
                                                                      forSearchQuery: query,
                                                                      withStats: true)
                            promise(.success(result))
                        } catch {
                            print("🦄 \(error)")
                            promise(.success([]))
                        }
                    }
                }
            }
            .receive(on: DispatchQueue.main)
            .map { games -> SearchState in
                if games.isEmpty {
                    return SearchState.noResults
                } else {
                    return SearchState.results(games)
                }
            }
            .eraseToAnyPublisher()
            .assign(to: &$boardGameResults)
        
        if let initialData {
            Just(SearchState.results(initialData))
                .assign(to: &$boardGameResults)
        }
    }
   
}
