//
//  File.swift
//  
//
//  Created by Trey on 10/24/23.
//

import Foundation
import UIKit

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
    public var descriptionTextDecoded: String? {
        String(htmlEncodedString: descriptionText)
    }
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
    public let descriptionTextDecoded: String?
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
        self.descriptionTextDecoded = String(htmlEncodedString: descriptionText)
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
                                        descriptionText: "Description from BoardgameNews&#10;&#10;In Agricola, you're a farmer in a wooden shack with your spouse and little else. On a turn, you get to take only two actions, one for you and one for the spouse, from all the possibilities you'll find on a farm: collecting clay, wood, or stone; building fences; and so on. You might think about having kids in order to get more work accomplished, but first you need to expand your house. And what are you going to feed all the little rugrats?&#10;&#10;The game supports many levels of complexity, mainly through the use (or non-use) of two of its main types of cards, Minor Improvements and Occupations. In the beginner's version (called the Family Variant in the U.S. release), these cards are not used at all. For advanced play, the U.S. release includes three levels of both types of cards; Basic (E-deck), Interactive (I-deck), and Complex (K-deck), and the rulebook encourages players to experiment with the various decks and mixtures thereof. Aftermarket decks such as the Z-Deck and the L-Deck also exist.&#10;&#10;Agricola is a turn-based game. There are 14 game rounds occurring in 6 stages, with a Harvest at the end of each stage (after Rounds 4, 7, 9, 11, 13, and 14).&#10;Each player starts with two playing tokens (farmer and spouse) and thus can take two turns, or actions, per round. There are multiple options, and while the game progresses, you'll have more and more: first thing in a round, a new action card is flipped over.&#10;Problem: Each action can be taken by only one player each round, so it's important to do some things with high preference.&#10;Each player also starts with a hand of 7 Occupation cards (of more than 160 total) and 7 Minor Improvement cards (of more than 140 total) that he/she may use during the game if they fit in his/her strategy. Speaking of which, there are countless strategies, some depending on your card hand. Sometimes it's a good choice to stay on course, and sometimes it is better to react to your opponents' actions...&#10;&#10;",
minPlaytime: 30,
maxPlaytime: 60,
avePlaytime: 45,
minAge: 12,
                                        averageRating: 7.23)
extension String {
    init?(htmlEncodedString: String?) {
        guard let htmlEncodedString else {
            return nil
        }
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        self.init(attributedString.string)
    }
}
