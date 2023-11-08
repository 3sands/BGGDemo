//
//  File.swift
//  
//
//  Created by Trey on 10/26/23.
//

import Foundation
import BGGDemoUtilities
import SWXMLHash

enum XMLDecodingStrings: String {
    case average
    case boardgame
    case description
    case id
    case image
    case item
    case items
    case minage
    case minplayers
    case maxplayers
    case minplaytime
    case maxplaytime
    case name
    case playingtime
    case primary
    case ratings
    case statistics
    case thumbnail
    case total
    case type
    case value
    case yearpublished
}

extension BoardGame: XMLObjectDeserialization {
    public static func deserialize(_ node: XMLIndexer) throws -> BoardGame {
        return try BoardGame(id: node.value(ofAttribute: XMLDecodingStrings.id.rawValue),
                             titles: node[XMLDecodingStrings.name.rawValue].value(),
                             mainTitle:  node[XMLDecodingStrings.name.rawValue].filterAll {
            elem, _ in elem.attribute(by: XMLDecodingStrings.type.rawValue)?.text == XMLDecodingStrings.primary.rawValue
        }
            .value(ofAttribute: XMLDecodingStrings.value.rawValue),
                             imageURL: node[XMLDecodingStrings.image.rawValue].value(),
                             thumbnailURL: node[XMLDecodingStrings.thumbnail.rawValue].value(),
                             minPlayers: node[XMLDecodingStrings.minplayers.rawValue].value(ofAttribute: XMLDecodingStrings.value.rawValue),
                             maxPlayers: node[XMLDecodingStrings.maxplayers.rawValue].value(ofAttribute: XMLDecodingStrings.value.rawValue),
                             yearPublished: node[XMLDecodingStrings.yearpublished.rawValue].value(ofAttribute: XMLDecodingStrings.value.rawValue),
                             descriptionText: node[XMLDecodingStrings.description.rawValue].value(),
                             minPlaytime: node[XMLDecodingStrings.minplaytime.rawValue].value(ofAttribute: XMLDecodingStrings.value.rawValue),
                             maxPlaytime: node[XMLDecodingStrings.maxplaytime.rawValue].value(ofAttribute: XMLDecodingStrings.value.rawValue),
                             avePlaytime: node[XMLDecodingStrings.playingtime.rawValue].value(ofAttribute: XMLDecodingStrings.value.rawValue),
                             minAge: node[XMLDecodingStrings.minage.rawValue].value(ofAttribute: XMLDecodingStrings.value.rawValue),
                             averageRating: node[XMLDecodingStrings.statistics][XMLDecodingStrings.ratings.rawValue][XMLDecodingStrings.average.rawValue].value(ofAttribute: XMLDecodingStrings.value.rawValue)
                             
        )
    }
}

extension BGGThing: XMLObjectDeserialization {
    public static func deserialize(_ node: XMLIndexer) throws -> BGGThing {
        guard let type: String = node.value(ofAttribute: XMLDecodingStrings.type.rawValue) else {
            throw CustomErrors.cannotGetTypeFromXML
        }
        
        switch type {
        case XMLDecodingStrings.boardgame.rawValue:
            return try .boardGame(.deserialize(node))
            // TODO: other cases
        default:
            // TODO Errors
            return .unknown
        }
    }
}

extension BGGSearchResponseItem: XMLObjectDeserialization {
    public static func deserialize(_ node: XMLIndexer) throws -> BGGSearchResponseItem {
        return try BGGSearchResponseItem(
            id: node.value(ofAttribute: XMLDecodingStrings.id.rawValue),
            name: node[XMLDecodingStrings.name.rawValue].value(ofAttribute: XMLDecodingStrings.value.rawValue),
            yearPublished: node[XMLDecodingStrings.yearpublished.rawValue].value(ofAttribute: XMLDecodingStrings.value.rawValue), 
            type: node.value(ofAttribute: XMLDecodingStrings.type.rawValue)
        )
    }
}

