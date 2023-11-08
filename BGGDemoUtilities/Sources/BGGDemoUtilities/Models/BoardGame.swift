//
//  File.swift
//  
//
//  Created by Trey on 10/24/23.
//

import Foundation

/// Entity for a Board Game
public struct BoardGameNew: Identifiable {
    /// ID on BGG
    public let id: Int
    
    /// Titles on BGG
    public let titles: [String]
    
    /// Main title on BGG
    public let mainTitle: String
    
    public let imageURL: String?
    
    public let thumbnailURL: String?
    public let playersNumbers: PlayersNumber
    public let yearPublished: Int?
    public let descriptionText: String?
    public let playtime: Playtime
    public let minAge: Int?
    public let averageRating: Float?
    
    public init(id: Int, titles: [String], mainTitle: String, imageURL: String?, thumbnailURL: String?, playersNumber: PlayersNumber, yearPublished: Int?, descriptionText: String?, playtime: Playtime, minAge: Int?, averageRating: Float?) {
        self.id = id
        self.titles = titles
        self.mainTitle = mainTitle
        self.imageURL = imageURL
        self.thumbnailURL = thumbnailURL
        self.playersNumbers = playersNumber
        self.yearPublished = yearPublished
        self.descriptionText = descriptionText
        self.playtime = playtime
        self.minAge = minAge
        self.averageRating = averageRating
    }
}

/// Entity for a Board Game
public struct BoardGame: Identifiable {
    /// ID on BGG
    public let id: Int
    
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
        self.id = id
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
    
    static var empty: Self {
        Self.init(id: 123, titles: [], mainTitle: "", imageURL: nil, thumbnailURL: nil, minPlayers: nil, maxPlayers: nil, yearPublished: nil, descriptionText: nil, minPlaytime: nil, maxPlaytime: nil, avePlaytime: nil, minAge: nil, averageRating: nil)
    }
}

public let previewBoardGame = BoardGame(id: 123456,
                                        titles: ["Agricola", "Agricoli"],
                                        mainTitle: "Agricola",
                                        imageURL: "https://www.mlbstatic.com/team-logos/share/429.jpg",
                                        thumbnailURL: "https://www.mlbstatic.com/team-logos/share/429.jpg",
                                        minPlayers: 1,
                                        maxPlayers: 2,
                                        yearPublished: 2007, 
                                        descriptionText: "This is the description",
minPlaytime: 30,
maxPlaytime: 60,
avePlaytime: 45,
minAge: 12,
                                        averageRating: 7.23)
