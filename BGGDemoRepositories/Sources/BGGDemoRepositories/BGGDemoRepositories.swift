// The Swift Programming Language
// https://docs.swift.org/swift-book

import BGGDemoNetworking
import BGGDemoUtilities
import SwiftData
import SwiftUI

public final class BGGDemoRepositories: BGGDemoRepositoryService {
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
                try? modelContext.save()
            }
        }
        
        return things
    }
    
    public func bggItem(forId id: Int) async throws -> BGGThing? {
        // if exists in cache, use it
        for fetcher: any Fetcher in [BoardGameExpansionFetcher(), BoardGameFetcher()] {
            if let bggThing = fetcher.fetch(modelContext: modelContext, id: id) {
                return bggThing
            }
        }
        
        return try await networking.search(geeksite: .boardGame, forIds: [id], withStats: true).first
    }
}
