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
    @Published private(set) var collectionResults: SearchState = .noResults
    
    enum SearchState {
        case noResults
        case results(UserCollection)
        case error
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
            .flatMap { userName -> Future<UserCollection, Never> in
                Future { promise in
                    Task {
                        do {
                            guard userName.isNotEmpty else {
                                promise(.success(UserCollection.empty))

                                return
                            }

                            let result = try await self.repo.collection(forUserName: userName)
                            promise(.success(result))
                        } catch {
                            promise(.success(UserCollection.empty))
                        }
                    }
                }
            }
            .receive(on: DispatchQueue.main)
            .map { userCollection -> SearchState in
                if userCollection.collection.isEmpty && userCollection.userName == "" {
                    return SearchState.noResults
                }
                
                return SearchState.results(userCollection)
            }
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
