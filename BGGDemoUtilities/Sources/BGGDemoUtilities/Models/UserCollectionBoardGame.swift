//
//  UserCollectionBoardGame.swift
//
//
//  Created by Trey on 12/1/23.
//

import Foundation

public struct UserCollectionBoardGame {
    public let bggId: Int
    public let name: String
    public let yearPublished: Int?
    public let imageURLString: String?
    public let imageThumbnailURLString: String?
    public let statuses: Set<UserCollectionGameStatus>
    public let numPlays: Int?
    public let comment: String?
    public let userRating: Float?
    public let averageCommunityRating: Float?
    
    public init(bggId: Int,
                name: String,
                yearPublished: Int?,
                imageURLString: String?,
                imageThumbnailURLString: String?,
                statuses: Set<UserCollectionGameStatus> = [],
                numPlays: Int?,
                comment: String?,
                userRating: Float?,
                averageCommunityRating: Float?) {
        self.bggId = bggId
        self.name = name
        self.yearPublished = yearPublished
        self.imageURLString = imageURLString
        self.imageThumbnailURLString = imageThumbnailURLString
        self.statuses = statuses
        self.numPlays = numPlays
        self.comment = comment
        self.userRating = userRating
        self.averageCommunityRating = averageCommunityRating
    }
    
    static var empty: Self {
        Self.init(bggId: 123,
                  name: "",
                  yearPublished: 2007,
                  imageURLString: nil,
                  imageThumbnailURLString: nil,
                  statuses: [],
                  numPlays: 0,
                  comment: nil,
                  userRating: nil,
                  averageCommunityRating: nil)
    }
}

public let previewUserCollectionBoardGame = UserCollectionBoardGame(bggId: 123456,
                                                                    name: "Agricola",
                                                                    yearPublished: 2007,
                                                                    imageURLString: "https://www.mlbstatic.com/team-logos/share/429.jpg",
                                                                    imageThumbnailURLString: "https://www.mlbstatic.com/team-logos/share/429.jpg",
                                                                    statuses: [.own, .forTrade, .preordered, .previouslyOwned, .want, .wantToBuy, .wantToPlay, .wishList],
                                                                    numPlays: 1,
                                                                    comment: "This is a super fun game",
                                                                    userRating: 10,
                                                                    averageCommunityRating: 9.9)
