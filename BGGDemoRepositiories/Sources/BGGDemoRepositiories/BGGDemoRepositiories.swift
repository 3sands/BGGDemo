// The Swift Programming Language
// https://docs.swift.org/swift-book

import BGGDemoNetworking
import BGGDemoUtilities
import SwiftData
import SwiftUI

protocol Fetcher {
    associatedtype DataObject: HasBGGThing & PersistentModel
    
    func fetch(modelContext: ModelContext, id: Int) -> BGGThing?
}

extension Fetcher {
    func fetch(modelContext: ModelContext, id: Int) -> BGGThing? {
        let descriptor = FetchDescriptor<DataObject>(predicate: #Predicate<DataObject> { $0.id.hashValue == id })
        
        do {
            let fetchedObject = try modelContext.fetch(descriptor)
            
            return fetchedObject.first?.bggThing
        } catch {
            return nil
        }

//        return try? modelContext.fetch(descriptor).first?.bggThing
    }
}

struct BoardGameFetcher: Fetcher {
    typealias DataObject = BoardGameDataObject
}

struct BoardGameExpansionFetcher: Fetcher {
    typealias DataObject = BoardGameExpansionDataObject
}

public final class BGGDemoRepositiories {
    private let networking: BGGNetworkingService
    private let tempBoardGameRepo: [String: BoardGame] = [:]
    private let modelContext: ModelContext
    
    public init(networking: BGGNetworkingService = BGGNetworker(),
                modelContext: ModelContext) {
        self.networking = networking
        self.modelContext = modelContext
    }
    
    public func bggItems(from geekSite: GeekSite, forSearchQuery query: String, withStats: Bool) async throws -> [BGGThing] {
        // Need to get the response of the search.
        let response = try await networking.search(geeksite: .boardGame, forQuery: query)
        
        // then do a second request to get data of the items returned
        // put in the persistence?
        let things = try await networking.search(geeksite: geekSite, forIds: response.items.reduce([]) { $0 + [$1.id] }, withStats: withStats)
        
        // persist each thing, must be done async?
        for thing in things {
            if let dataObject = thing.dataObject {
                modelContext.insert(dataObject)
            }
        }
        return things
    }
    
    public func bggItem(forId id: Int) async throws -> BGGThing? {
        // if exists in cache, use it
        for fetcher: any Fetcher in [BoardGameFetcher(), BoardGameExpansionFetcher()] {
            if let bggThing = fetcher.fetch(modelContext: modelContext, id: id) {
                return bggThing
            }
        }
        
        return try await networking.search(geeksite: .boardGame, forIds: [id], withStats: true).first
    }
}

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
    @Attribute(.unique) public let id: Int
    
    public init(id: Int) {
        self.id = id
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
    @Attribute(.unique) public let id: Int
    
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
    
    init(id: Int, titles: [String], mainTitle: String, imageURL: String?, thumbnailURL: String?, minPlayers: Int?, maxPlayers: Int?, yearPublished: Int?, descriptionText: String?, minPlaytime: Int?, maxPlaytime: Int?, avePlaytime: Int?, minAge: Int?, averageRating: Float?) {
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
    
    init(game: BoardGame) {
        self.id = game.id
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
        BoardGameNew(id: self.id, titles: self.titles, mainTitle: self.mainTitle, imageURL: self.imageURL, thumbnailURL: self.thumbnailURL, playersNumber: PlayersNumber(minimum: self.minPlayers, maximum: self.maxPlayers), yearPublished: self.yearPublished, descriptionText: self.descriptionText, playtime: Playtime(minimum: self.minPlaytime, maximum: self.maxPlaytime, average: self.avePlaytime), minAge: self.minAge, averageRating: self.averageRating)
    }
    
    var boardGame: BoardGame {
        BoardGame(id: self.id, titles: self.titles, mainTitle: self.mainTitle, imageURL: self.imageURL, thumbnailURL: self.thumbnailURL, minPlayers: self.minPlayers, maxPlayers: self.maxPlayers, yearPublished: self.yearPublished, descriptionText: self.descriptionText, minPlaytime: self.minPlaytime, maxPlaytime: self.maxPlaytime, avePlaytime: self.avePlaytime, minAge: self.minAge, averageRating: self.averageRating)
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
