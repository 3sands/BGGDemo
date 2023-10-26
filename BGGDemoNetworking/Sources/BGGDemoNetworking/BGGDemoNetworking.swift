// The Swift Programming Language
// https://docs.swift.org/swift-book

import BGGDemoUtilities
import SWXMLHash
import Foundation

public protocol BGGNetworkingService {
    func search(geeksite: GeekSite, forQuery: String, withStats: Bool) async throws -> [BGGThing]
}

public class BGGNetworker: BGGNetworkingService {
    public init() { }

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
}
