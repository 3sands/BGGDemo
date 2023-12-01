//
//  UserCollectionThing.swift
//
//
//  Created by Trey on 12/1/23.
//

import Foundation

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
