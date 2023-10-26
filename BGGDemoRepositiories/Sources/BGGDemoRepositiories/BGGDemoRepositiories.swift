// The Swift Programming Language
// https://docs.swift.org/swift-book

import BGGDemoNetworking
import BGGDemoUtilities

public final class BGGDemoRepositiories {
    private let networking: BGGNetworkingService
    private let tempBoardGameRepo: [String: BoardGame] = [:]
    
    public init(networking: BGGNetworkingService = BGGNetworker()) {
        self.networking = networking
    }
    
//    public func boardGamesFor(searchQuery: String) async -> Result<[BoardGame], Error> {
//        // put into the repo
//        return await networking.searchBoardGames(for: searchQuery)
////        let gameTitles = await networking.search(for: searchQuery)
////        return .success([])
//    }
    
    public func bggItems(from geekSite: GeekSite, forSearchQuery query: String) async throws -> [BGGThing] {
        return try await networking.search(geeksite: geekSite, forQuery: query)
    }
}
