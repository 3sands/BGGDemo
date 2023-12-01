//
//  BGGThing.swift
//
//
//  Created by Trey on 10/25/23.
//

import Foundation

/// Literally called a THINGTYPE in the documentation on https://boardgamegeek.com/wiki/page/BGG_XML_API2 so going to the similar
/// What each kind of object can be with its associated Data type.
public enum BGGThing: Identifiable, CaseIterable {
    public static var allCases: [BGGThing] {
        [.boardGame(.empty), .boardGameExpansion, .boardGameAccessory, .videoGame, .rpgItem, .rpgIssue, .unknown]
    }
    
    case boardGame(BoardGame)
    case boardGameExpansion // TODO: AssociaatedStruct
    case boardGameAccessory // TODO: Struct
    case videoGame // TODO
    case rpgItem
    case rpgIssue // (for periodicals)
    case unknown
    
    public var id: Int {
        switch self {
        case .boardGame(let game):
            return game.id
        default:
            // TODO
            return UUID.init().hashValue
        }
    }
    
    public var boardGame: BoardGame? {
        switch self {
        case .boardGame(let boardGame):
            return boardGame
        case .boardGameExpansion,
                .boardGameAccessory,
                .videoGame,
                .rpgItem,
                .rpgIssue,
                .unknown:
            return nil
        }
    }
}
