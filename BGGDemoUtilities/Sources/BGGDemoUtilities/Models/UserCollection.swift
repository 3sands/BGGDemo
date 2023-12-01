//
//  UserCollection.swift
//
//
//  Created by Trey on 11/29/23.
//

import Foundation

public struct UserCollection {
    public init(userName: String,
                collection: [UserCollectionThing]) {
        self.userName = userName
        self.collection = collection
    }
    
    public let userName: String
    public let collection: [UserCollectionThing]
    
    public static let empty: UserCollection = UserCollection(userName: "",
                                                             collection: [])
}

public enum UserCollectionThing: Identifiable, CaseIterable {
    public static var allCases: [UserCollectionThing] {
        [.boardGame(.empty), .boardGameExpansion]
    }
    
    case boardGame(UserCollectionBoardGame)
    case boardGameExpansion // TODO: AssociaatedStruct
    case unknown
    
    public var id: Int {
        switch self {
        case .boardGame(let game):
            return game.bggId
        default:
            // TODO
            return UUID.init().hashValue
        }
    }
}

public let previewUserCollection: UserCollection = .init(userName: "testUser",
                                                         collection: [.boardGame(previewUserCollectionBoardGame)])
