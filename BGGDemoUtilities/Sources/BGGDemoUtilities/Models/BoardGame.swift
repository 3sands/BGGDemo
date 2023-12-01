//
//  BoardGame.swift
//
//
//  Created by Trey on 10/24/23.
//

import Foundation
import UIKit

/// Entity for a Board Game
public struct BoardGame: Identifiable {
    /// ID on BGG
    public let id: Int
    
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
    public let descriptionTextDecoded: String?
    public let minPlaytime: Int?
    public let maxPlaytime: Int?
    public let avePlaytime: Int?
    public let minAge: Int?
    public let averageCommunityRating: Float?
    // TODO: Add [BG Category]
    // TODO: Add [BG Mechanic]
    // TODO: Add [BG Family]
    // TODO: Add [BG Expansions] (Can also then add in buttons to navigate to their detail page)
    // TODO: Add [BG Accessory] (Can also then add in buttons to navigate to their detail page)
    // TODO: Add [BG Implementation]
    // TODO: Add [boardgamedesigner]
    // TODO: Add [boardgameartist]
    // TODO: Add [boardgamepublisher]
    // TODO: Add suggested player age poll statistics
    // TODO: Add language dependence poll statistics
    // TODO: Add suggested number of players poll statistics
    
    public init(id: Int,
                titles: [String],
                mainTitle: String,
                imageURLString: String?,
                imageThumbnailURLString: String?,
                minPlayers: Int?,
                maxPlayers: Int?, yearPublished: Int?,
                descriptionText: String?,
                minPlaytime: Int?,
                maxPlaytime: Int?,
                avePlaytime: Int?,
                minAge: Int?,
                averageCommunityRating: Float?) {
        self.id = id
        self.titles = titles
        self.mainTitle = mainTitle
        self.imageURLString = imageURLString
        self.imageThumbnailURLString = imageThumbnailURLString
        self.minPlayers = minPlayers
        self.maxPlayers = maxPlayers
        self.yearPublished = yearPublished
        self.descriptionText = descriptionText
        self.descriptionTextDecoded = String(htmlEncodedString: descriptionText)
        self.minPlaytime = minPlaytime
        self.maxPlaytime = maxPlaytime
        self.avePlaytime = avePlaytime
        self.minAge = minAge
        self.averageCommunityRating = averageCommunityRating
    }
    
    static var empty: Self {
        Self.init(id: 123,
                  titles: [],
                  mainTitle: "",
                  imageURLString: nil,
                  imageThumbnailURLString: nil,
                  minPlayers: nil,
                  maxPlayers: nil,
                  yearPublished: nil,
                  descriptionText: nil,
                  minPlaytime: nil,
                  maxPlaytime: nil,
                  avePlaytime: nil,
                  minAge: nil,
                  averageCommunityRating: nil)
    }
}

public let previewBoardGame = BoardGame(id: 123456,
                                        titles: ["Agricola", "Agricoli"],
                                        mainTitle: "Agricola",
                                        imageURLString: "https://www.mlbstatic.com/team-logos/share/429.jpg",
                                        imageThumbnailURLString: "https://www.mlbstatic.com/team-logos/share/429.jpg",
                                        minPlayers: 1,
                                        maxPlayers: 2,
                                        yearPublished: 2007,
                                        descriptionText: "Description from BoardgameNews&#10;&#10;In Agricola, you're a farmer in a wooden shack with your spouse and little else. On a turn, you get to take only two actions, one for you and one for the spouse, from all the possibilities you'll find on a farm: collecting clay, wood, or stone; building fences; and so on. You might think about having kids in order to get more work accomplished, but first you need to expand your house. And what are you going to feed all the little rugrats?&#10;&#10;The game supports many levels of complexity, mainly through the use (or non-use) of two of its main types of cards, Minor Improvements and Occupations. In the beginner's version (called the Family Variant in the U.S. release), these cards are not used at all. For advanced play, the U.S. release includes three levels of both types of cards; Basic (E-deck), Interactive (I-deck), and Complex (K-deck), and the rulebook encourages players to experiment with the various decks and mixtures thereof. Aftermarket decks such as the Z-Deck and the L-Deck also exist.&#10;&#10;Agricola is a turn-based game. There are 14 game rounds occurring in 6 stages, with a Harvest at the end of each stage (after Rounds 4, 7, 9, 11, 13, and 14).&#10;Each player starts with two playing tokens (farmer and spouse) and thus can take two turns, or actions, per round. There are multiple options, and while the game progresses, you'll have more and more: first thing in a round, a new action card is flipped over.&#10;Problem: Each action can be taken by only one player each round, so it's important to do some things with high preference.&#10;Each player also starts with a hand of 7 Occupation cards (of more than 160 total) and 7 Minor Improvement cards (of more than 140 total) that he/she may use during the game if they fit in his/her strategy. Speaking of which, there are countless strategies, some depending on your card hand. Sometimes it's a good choice to stay on course, and sometimes it is better to react to your opponents' actions...&#10;&#10;",
                                        minPlaytime: 30,
                                        maxPlaytime: 60,
                                        avePlaytime: 45,
                                        minAge: 12,
                                        averageCommunityRating: 7.23)
