//
//  File.swift
//  
//
//  Created by Trey on 11/9/23.
//

import Foundation
import BGGDemoUtilities
import SwiftData

@Model
class SearchQueryResponseDataObject {
    public let query: String
    public let responseItems: [SearchQueryResponseItem]
    
    public init(query: String, responseItems: [SearchQueryResponseItem]) {
        self.query = query
        self.responseItems = responseItems
    }
}

@Model
class SearchQueryResponseItem {
        let id: Int
        let name: String
        let yearPublished: Int?
        let type: String
    
    init(id: Int, name: String, yearPublished: Int?, type: String) {
        self.id = id
        self.name = name
        self.yearPublished = yearPublished
        self.type = type
    }
}

@Model
public class BoardGameExpansionDataObject {
    /// ID on BGG
    @Attribute(.unique) public let bggId: Int
    
    public init(id: Int) {
        self.bggId = id
    }
}

extension BoardGameExpansionDataObject: HasBGGThing {
    var bggThing: BGGThing { .boardGameExpansion }
    
    func getSelf() -> Self {
        self
    }
}

@Model
public class BoardGameDataObject {
    /// ID on BGG
    @Attribute(.unique) public let bggId: Int
    
    /// Titles on BGG
    public let titles: [String]
    
    /// Main title on BGG
    public let mainTitle: String
    
    public let imageURL: String?
    
    public let thumbnailURL: String?
    public let minPlayers: Int?
    public let maxPlayers: Int?
    public let yearPublished: Int?
    public let descriptionText: String?
    public let minPlaytime: Int?
    public let maxPlaytime: Int?
    public let avePlaytime: Int?
    public let minAge: Int?
    public let averageRating: Float?
    
    public init(id: Int, titles: [String], mainTitle: String, imageURL: String?, thumbnailURL: String?, minPlayers: Int?, maxPlayers: Int?, yearPublished: Int?, descriptionText: String?, minPlaytime: Int?, maxPlaytime: Int?, avePlaytime: Int?, minAge: Int?, averageRating: Float?) {
        self.bggId = id
        self.titles = titles
        self.mainTitle = mainTitle
        self.imageURL = imageURL
        self.thumbnailURL = thumbnailURL
        self.minPlayers = minPlayers
        self.maxPlayers = maxPlayers
        self.yearPublished = yearPublished
        self.descriptionText = descriptionText
        self.minPlaytime = minPlaytime
        self.maxPlaytime = maxPlaytime
        self.avePlaytime = avePlaytime
        self.minAge = minAge
        self.averageRating = averageRating
    }
    
    public init(game: BoardGame) {
        self.bggId = game.id
        self.titles = game.titles
        self.mainTitle = game.mainTitle
        self.imageURL = game.imageURL
        self.thumbnailURL = game.thumbnailURL
        self.minPlayers = game.minPlayers
        self.maxPlayers = game.maxPlayers
        self.yearPublished = game.yearPublished
        self.descriptionText = game.descriptionText
        self.minPlaytime = game.minPlaytime
        self.maxPlaytime = game.maxPlaytime
        self.avePlaytime = game.avePlaytime
        self.minAge = game.minAge
        self.averageRating = game.averageRating
    }
}

protocol SwiftDataObjectMakeable {
    var dataObject: (any PersistentModel)? { get }
}

extension BoardGameDataObject: HasBGGThing {
    
    var boardGameNew: BoardGameNew {
        BoardGameNew(id: self.bggId, titles: self.titles, mainTitle: self.mainTitle, imageURL: self.imageURL, thumbnailURL: self.thumbnailURL, playersNumber: PlayersNumber(minimum: self.minPlayers, maximum: self.maxPlayers), yearPublished: self.yearPublished, descriptionText: self.descriptionText, playtime: Playtime(minimum: self.minPlaytime, maximum: self.maxPlaytime, average: self.avePlaytime), minAge: self.minAge, averageRating: self.averageRating)
    }
    
    var boardGame: BoardGame {
        BoardGame(id: self.bggId, titles: self.titles, mainTitle: self.mainTitle, imageURL: self.imageURL, thumbnailURL: self.thumbnailURL, minPlayers: self.minPlayers, maxPlayers: self.maxPlayers, yearPublished: self.yearPublished, descriptionText: self.descriptionText, minPlaytime: self.minPlaytime, maxPlaytime: self.maxPlaytime, avePlaytime: self.avePlaytime, minAge: self.minAge, averageRating: self.averageRating)
    }
    
    var bggThing: BGGThing {
        return .boardGame(boardGame)
    }
    
    func getSelf() -> Self {
        self
    }
}

protocol HasBGGThing {
    var bggThing: BGGThing { get }
    var bggId: Int { get }
}

extension BGGThing: SwiftDataObjectMakeable {
    
    var dataObject: (any PersistentModel)? {
        switch self {
        case .boardGame(let boardGame):
            return BoardGameDataObject(game: boardGame)
        case .boardGameExpansion:
            return nil
        case .boardGameAccessory:
            return nil
        case .videoGame:
            return nil
        case .rpgItem:
            return nil
        case .rpgIssue:
            return nil
        case .unknown:
            return nil
        }
    }
}
