//
//  BGGUserCollectionViewModel.swift
//  BGGDemo
//
//  Created by Trey on 11/29/23.
//

import Combine
import Foundation
import SwiftData
import BGGDemoRepositories
import BGGDemoUtilities
import BGGDemoUIComponents

@MainActor
class BGGUserCollectionViewModel: ObservableObject {
    let repo: BGGDemoRepositoryService
    // input
    @Published var userName: String = ""
    
    // output
    @Published private(set) var collectionResults: SearchState = .emptySearchTerm
    
    enum SearchState {
        case emptySearchTerm
        case noResults
        case results(UserCollection)
        case error(Error)
    }

    // TODO: save user collection OR save username and/or make the call each time
    
    init(initialData: UserCollection? = nil,
         repo: BGGDemoRepositoryService) {
        self.repo = repo
        
        setupSearchForUserCollectionAfterSearchTermInputChanges()
        initializeUserCollectionView(from: initialData)
    }
    
    /// Binds searching for user collection after the search input changes to the collection results publisher
    private func setupSearchForUserCollectionAfterSearchTermInputChanges() {
        $userName
            .debounce(for: .milliseconds(300),
                      scheduler: DispatchQueue.main)
            .removeDuplicates()
            .flatMap { userName -> Future<SearchState, Never> in
                Future { promise in
                    Task {
                        do {
                            guard userName.isNotEmpty else {
                                promise(.success(.emptySearchTerm))

                                return
                            }

                            let result = try await self.repo.collection(forUserName: userName)
                            
                            guard result.collection.isNotEmpty else {
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
            .assign(to: &$collectionResults)
    }
    
    /// Initializes the user collection view with any cached  result
    /// - Parameter userCollection: initial cached user collection
    private func initializeUserCollectionView(from userCollection: UserCollection? = nil) {
        if let userCollection {
            Just(SearchState.results(userCollection))
                .assign(to: &$collectionResults)
        }
    }
}
