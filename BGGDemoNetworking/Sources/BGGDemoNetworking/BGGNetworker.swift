// The Swift Programming Language
// https://docs.swift.org/swift-book

import BGGDemoUtilities
import SWXMLHash
import Foundation

public class BGGNetworker: BGGNetworkingService {
    public init() { }
    
    public func search(geeksite: GeekSite, forQuery query: String) async throws -> BGGSearchResponse {
        // Make the url of the initial search for query, download the data, and attempt to parse into xml
        guard let url = Endpoint.search(geekSite: geeksite, query: query).url else {
            throw CustomErrors.missingSearchForQueryURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)

        guard let resultXMLString = String(data: data, encoding: .utf8) else {
            throw CustomErrors.cannotConvertSearchResultIntoXMLString
        }

        let resultXML = XMLHash.parse(resultXMLString)
        // BGG has an annoying API where the initial search results only return the title and the ID, no other info.
        // Need to do another call with all the IDs in this result to get the other results.
        // Will then need to do image thumbnails
        let results: [BGGSearchResponseItem] = try resultXML[XMLDecodingStrings.items.rawValue][XMLDecodingStrings.item.rawValue].value()
        
        return BGGSearchResponse(query: query, items: results)
    }
    
    public func search(geeksite: GeekSite, forIds ids: [Int], withStats: Bool) async throws -> [BGGThing] {
        // BGG has an annoying API where the initial search results only return the title and the ID, no other info.
        // Need to do another call with all the IDs in this result to get the other results.
        // Will then need to do image thumbnails
        var results = ids
        let first = results.removeFirst()
        let gameIdsToSearch = results.reduce("\(first)") { old, new in "\(old),\(new)"}
        
        // Make the url of the search for IDs, download the data, and attempt to parse into xml
        guard let newURL = Endpoint.searchForIds(geekSite: .boardGame,
                                                 idString: gameIdsToSearch,
                                                 withStats: withStats).url else {
            throw CustomErrors.missingSearchForIdsURL
        }
        
        let (gamesData, _) = try await URLSession.shared.data(from: newURL)
        guard let gamesXMLString = String(data: gamesData, encoding: .utf8) else {
            throw CustomErrors.cannotConvertSearchIdsResultIntoXMLString
        }
        let gameXMLHash = XMLHash.parse(gamesXMLString)
        // convert XML into the BGGThings to be displayed
        let bggThings: [BGGThing] = try gameXMLHash[XMLDecodingStrings.items.rawValue][XMLDecodingStrings.item.rawValue].value()

        return bggThings
    }

    public func search(geeksite: GeekSite, forQuery query: String, withStats: Bool) async throws -> [BGGThing] {
        // Make the url of the initial search for query, download the data, and attempt to parse into xml
        guard let url = Endpoint.search(geekSite: geeksite, query: query).url else {
            throw CustomErrors.missingSearchForQueryURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)

        guard let resultXMLString = String(data: data, encoding: .utf8) else {
            throw CustomErrors.cannotConvertSearchResultIntoXMLString
        }

        let resultXML = XMLHash.parse(resultXMLString)
        // split this function up
        
        
        
        // BGG has an annoying API where the initial search results only return the title and the ID, no other info.
        // Need to do another call with all the IDs in this result to get the other results.
        // Will then need to do image thumbnails
        var results: [BGGSearchResponseItem] = try resultXML[XMLDecodingStrings.items.rawValue][XMLDecodingStrings.item.rawValue].value()
        let first = results.removeFirst().id
        let gameIdsToSearch = results.reduce("\(first)") { old, new in "\(old),\(new.id)"}
        
        // Make the url of the search for IDs, download the data, and attempt to parse into xml
        guard let newURL = Endpoint.searchForIds(geekSite: .boardGame,
                                                 idString: gameIdsToSearch, 
                                                 withStats: withStats).url else {
            throw CustomErrors.missingSearchForIdsURL
        }
        
        let (gamesData, _) = try await URLSession.shared.data(from: newURL)
        guard let gamesXMLString = String(data: gamesData, encoding: .utf8) else {
            throw CustomErrors.cannotConvertSearchIdsResultIntoXMLString
        }
        let gameXMLHash = XMLHash.parse(gamesXMLString)
        // convert XML into the BGGThings to be displayed
        let bggThings: [BGGThing] = try gameXMLHash[XMLDecodingStrings.items.rawValue][XMLDecodingStrings.item.rawValue].value()

        return bggThings
    }
    
    public func retrieveUserCollection(geeksite: BGGDemoUtilities.GeekSite, 
                                       forUserName userName: String) async throws -> UserCollection {
        // FROM BGG: Note that the default (or using subtype=boardgame) returns both boardgame and boardgameexpansion's in your collection...
        // but incorrectly gives subtype=boardgame for the expansions. Workaround is to use excludesubtype=boardgameexpansion and
        // make a 2nd call asking for subtype=boardgameexpansion
        
        // Make the call for only the boardGames
        
        for _ in 0..<3 {
            guard let url = Endpoint.userCollection(geekSite: .boardGame, userName: userName, withExpansions: false).url else {
                throw CustomErrors.missingUserNameURL
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            // BGG API: Note that you should check the response status code...
            // if it's 202 (vs. 200) then it indicates BGG has queued your request and you need to keep retrying (hopefully w/some delay between tries) until the status is not 202.
            
            if response.statusCode == ResponseCodes.userCollectionRetry {
                let oneSecond = TimeInterval(1_000_000_000)
                let delay = UInt64(oneSecond * 0.3)
                try await Task<Never, Never>.sleep(nanoseconds: delay)

                continue
            }
            
            guard let resultXMLString = String(data: data, encoding: .utf8) else {
                throw CustomErrors.cannotConvertSearchResultIntoXMLString
            }
            
            let resultXML = XMLHash.parse(resultXMLString)

            // BGG has an annoying API where the initial search results only return the title and the ID, no other info.
            // Need to do another call with all the IDs in this result to get the other results.
            // Will then need to do image thumbnails
            let results: [UserCollectionThing] = try resultXML[XMLDecodingStrings.items.rawValue][XMLDecodingStrings.item.rawValue].value()

            // TODO make the call the expansions
            
            return UserCollection(userName: userName, collection: results)
        }
        
        throw CustomErrors.userCollectionFailed
    }
    
    private enum ResponseCodes {
        static let userCollectionRetry = 202
        static let userCollectionReady = 200
    }
}
