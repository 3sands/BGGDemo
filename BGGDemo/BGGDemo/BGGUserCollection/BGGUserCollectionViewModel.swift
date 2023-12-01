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

    init(initialData: UserCollection? = nil,
         repo: BGGDemoRepositoryService) {
        self.repo = repo
        
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
        
        if let initialData {
            Just(SearchState.results(initialData))
                .assign(to: &$collectionResults)
        }
    }
}
