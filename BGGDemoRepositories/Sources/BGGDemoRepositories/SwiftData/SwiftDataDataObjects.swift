//
//  SwiftDataDataObjects.swift
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
    
    public let imageURLString: String?
    
    public let imageThumbnailURLString: String?
    public let minPlayers: Int?
    public let maxPlayers: Int?
    public let yearPublished: Int?
    public let descriptionText: String?
    public let minPlaytime: Int?
    public let maxPlaytime: Int?
    public let avePlaytime: Int?
    public let minAge: Int?
    public let averageCommunityRating: Float?
    
    public init(id: Int, 
                titles: [String],
                mainTitle: String,
                imageURLString: String?,
                imageThumbnailURLString: String?,
                minPlayers: Int?,
                maxPlayers: Int?,
                yearPublished: Int?,
                descriptionText: String?,
                minPlaytime: Int?,
                maxPlaytime: Int?,
                avePlaytime: Int?,
                minAge: Int?,
                averageCommunityRating: Float?) {
        self.bggId = id
        self.titles = titles
        self.mainTitle = mainTitle
        self.imageURLString = imageURLString
        self.imageThumbnailURLString = imageThumbnailURLString
        self.minPlayers = minPlayers
        self.maxPlayers = maxPlayers
        self.yearPublished = yearPublished
        self.descriptionText = descriptionText
        self.minPlaytime = minPlaytime
        self.maxPlaytime = maxPlaytime
        self.avePlaytime = avePlaytime
        self.minAge = minAge
        self.averageCommunityRating = averageCommunityRating
    }
    
    public init(game: BoardGame) {
        self.bggId = game.id
        self.titles = game.titles
        self.mainTitle = game.mainTitle
        self.imageURLString = game.imageURLString
        self.imageThumbnailURLString = game.imageThumbnailURLString
        self.minPlayers = game.minPlayers
        self.maxPlayers = game.maxPlayers
        self.yearPublished = game.yearPublished
        self.descriptionText = game.descriptionText
        self.minPlaytime = game.minPlaytime
        self.maxPlaytime = game.maxPlaytime
        self.avePlaytime = game.avePlaytime
        self.minAge = game.minAge
        self.averageCommunityRating = game.averageCommunityRating
    }
}

protocol SwiftDataObjectMakeable {
    var dataObject: (any PersistentModel)? { get }
}

extension BoardGameDataObject: HasBGGThing {
    
    var boardGame: BoardGame {
        BoardGame(id: self.bggId, 
                  titles: self.titles,
                  mainTitle: self.mainTitle,
                  imageURLString: self.imageURLString,
                  imageThumbnailURLString: self.imageThumbnailURLString,
                  minPlayers: self.minPlayers,
                  maxPlayers: self.maxPlayers,
                  yearPublished: self.yearPublished,
                  descriptionText: self.descriptionText,
                  minPlaytime: self.minPlaytime, 
                  maxPlaytime: self.maxPlaytime,
                  avePlaytime: self.avePlaytime,
                  minAge: self.minAge,
                  averageCommunityRating: self.averageCommunityRating)
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
