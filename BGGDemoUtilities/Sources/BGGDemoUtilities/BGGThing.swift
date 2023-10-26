//
//  File.swift
//  
//
//  Created by Trey on 10/25/23.
//

import Foundation

/// Literally called a THINGTYPE in the documentation on https://boardgamegeek.com/wiki/page/BGG_XML_API2 so going to the similar
/// What each kind of object can be with its associated Data type.
public enum BGGThing: Identifiable {
    case boardGame(BoardGame)
    case boardGameExpansion // TODO: AssociaatedStruct
    case boardGamAaccessory // TODO: Struct
    case videoGame // TODO
    case rpgItem
    case rpgIssue // (for periodicals)
    
    public var id: Int {
        switch self {
        case .boardGame(let game):
            return game.id
        default:
            // TODO
            return 0
        }
    }
}
