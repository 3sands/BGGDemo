//
//  XMLObjectDeserializationExtensions.swift
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
    case boardgameexpansion
    case comment
    case description
    case error
    case errors
    case id
    case image
    case item
    case items
    case message
    case minage
    case minplayers
    case maxplayers
    case minplaytime
    case maxplaytime
    case name
    case numplays
    case objectid
    case playingtime
    case primary
    case rating
    case ratings
    case statistics
    case stats
    case status
    case subtype
    case thumbnail
    case total
    case totalitems
    case type
    case value
    case yearpublished
    
    // in case its different
    var decodeKey: String {
        rawValue
    }
}

extension BoardGame: XMLObjectDeserialization {
    public static func deserialize(_ node: XMLIndexer) throws -> BoardGame {
        return try BoardGame(id: node.value(ofAttribute: XMLDecodingStrings.id.decodeKey),
                             titles: node[XMLDecodingStrings.name.decodeKey].value(),
                             mainTitle:  node[XMLDecodingStrings.name.decodeKey].filterAll {
            elem, _ in elem.attribute(by: XMLDecodingStrings.type.decodeKey)?.text == XMLDecodingStrings.primary.decodeKey
        }
            .value(ofAttribute: XMLDecodingStrings.value.decodeKey),
                             imageURLString: node[XMLDecodingStrings.image.decodeKey].value(),
                             imageThumbnailURLString: node[XMLDecodingStrings.thumbnail.decodeKey].value(),
                             minPlayers: node[XMLDecodingStrings.minplayers.decodeKey].value(ofAttribute: XMLDecodingStrings.value.decodeKey),
                             maxPlayers: node[XMLDecodingStrings.maxplayers.decodeKey].value(ofAttribute: XMLDecodingStrings.value.decodeKey),
                             yearPublished: node[XMLDecodingStrings.yearpublished.decodeKey].value(ofAttribute: XMLDecodingStrings.value.decodeKey),
                             descriptionText: node[XMLDecodingStrings.description.decodeKey].value(),
                             minPlaytime: node[XMLDecodingStrings.minplaytime.decodeKey].value(ofAttribute: XMLDecodingStrings.value.decodeKey),
                             maxPlaytime: node[XMLDecodingStrings.maxplaytime.decodeKey].value(ofAttribute: XMLDecodingStrings.value.decodeKey),
                             avePlaytime: node[XMLDecodingStrings.playingtime.decodeKey].value(ofAttribute: XMLDecodingStrings.value.decodeKey),
                             minAge: node[XMLDecodingStrings.minage.decodeKey].value(ofAttribute: XMLDecodingStrings.value.decodeKey),
                             averageCommunityRating: node[XMLDecodingStrings.statistics][XMLDecodingStrings.ratings.decodeKey][XMLDecodingStrings.average.decodeKey].value(ofAttribute: XMLDecodingStrings.value.decodeKey)
                             
        )
    }
}

extension BGGThing: XMLObjectDeserialization {
    public static func deserialize(_ node: XMLIndexer) throws -> BGGThing {
        guard let type: String = node.value(ofAttribute: XMLDecodingStrings.type.decodeKey) else {
            throw CustomErrors.cannotGetTypeFromXML
        }
        
        switch type {
        case XMLDecodingStrings.boardgame.decodeKey:
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
            id: node.value(ofAttribute: XMLDecodingStrings.id.decodeKey),
            name: node[XMLDecodingStrings.name.decodeKey].value(ofAttribute: XMLDecodingStrings.value.decodeKey),
            yearPublished: node[XMLDecodingStrings.yearpublished.decodeKey].value(ofAttribute: XMLDecodingStrings.value.decodeKey), 
            type: node.value(ofAttribute: XMLDecodingStrings.type.decodeKey)
        )
    }
}

extension UserCollection: XMLObjectDeserialization {
    
}

extension UserCollectionThing: XMLObjectDeserialization {
    public static func deserialize(_ node: XMLIndexer) throws -> UserCollectionThing {
        guard let type: String = node.value(ofAttribute: XMLDecodingStrings.subtype.decodeKey) else {
            throw CustomErrors.cannotGetTypeFromXML
        }
        
        switch type {
        case XMLDecodingStrings.boardgame.decodeKey:
            return try .boardGame(.deserialize(node))
            // TODO: other cases
        case XMLDecodingStrings.boardgameexpansion.decodeKey:
            return .boardGameExpansion
        default:
            // TODO Errors
            return .unknown
        }
    }
}

extension UserCollectionBoardGame: XMLObjectDeserialization {
    public static func deserialize(_ node: XMLIndexer) throws -> UserCollectionBoardGame {
        return try UserCollectionBoardGame(bggId: node.value(ofAttribute: XMLDecodingStrings.objectid.decodeKey),
                                           name: node[XMLDecodingStrings.name.decodeKey].value(),
                                           yearPublished: node[XMLDecodingStrings.yearpublished.decodeKey].value(),
                                           imageURLString: node[XMLDecodingStrings.image.decodeKey].value(),
                                           imageThumbnailURLString: node[XMLDecodingStrings.thumbnail.decodeKey].value(),
                                           statuses: node[XMLDecodingStrings.status.decodeKey].value(),
                                           numPlays: node[XMLDecodingStrings.numplays.decodeKey].value(),
                                           comment: node[XMLDecodingStrings.comment.decodeKey].value(),
                                           userRating: node[XMLDecodingStrings.stats.decodeKey][XMLDecodingStrings.rating.decodeKey].value(ofAttribute: XMLDecodingStrings.value.decodeKey),
                                           averageCommunityRating: node[XMLDecodingStrings.stats.decodeKey][XMLDecodingStrings.rating.decodeKey][XMLDecodingStrings.average.decodeKey].value(ofAttribute: XMLDecodingStrings.value.decodeKey))
    }
}

extension Set<UserCollectionGameStatus>: XMLObjectDeserialization {
    public static func deserialize(_ element: XMLIndexer) throws -> Set<UserCollectionGameStatus> {
        var returnSet: Set<UserCollectionGameStatus> = []
        
        for status in UserCollectionGameStatus.allCases {
            if let intValue: Int = element.value(ofAttribute: status.codingKey),
                intValue == 1 {
                returnSet.insert(status)
            }
        }
        
        return returnSet
    }
}
