// The Swift Programming Language
// https://docs.swift.org/swift-book

import BGGDemoUtilities
import SWXMLHash
import Foundation

public protocol BGGNetworkingService {
    func search(geeksite: GeekSite, forQuery: String) async throws -> [BGGThing]
}

public class BGGNetworker: BGGNetworkingService {
    public init() {
        
    }
    
    public func search(geeksite: GeekSite, forQuery query: String) async throws -> [BGGThing] {
        // make the url of the initial search
        guard let url = Endpoint.search(geekSite: geeksite, query: query).url else {
            // todo: rename
            throw CustomErrors.wrongSearchURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let resultXMLString = String(data: data, encoding: .utf8) else {
            throw CustomErrors.wrongSearchURL
        }
        
        let resultXML = XMLHash.parse(resultXMLString)
        let resultCount: Int = try resultXML["items"].value(ofAttribute: "total")
        // BGG has an annoying API where the initial search results only return the title and the ID, no other info.
        // Need to do another call with all the IDs in this result to get the other results.
        // Will then need to do image thumbnails
        var results: [BGGResponseItem] = try resultXML["items"]["item"].value()
        let first = results.removeFirst().id
        let gameIdsToSearch = results.reduce("\(first)") { old, new in "\(old),\(new.id)"}
        
        print("🦄 result count is \(resultCount)")
        print("🦄 results are \(results)")
        print(" fameIDsToSearch \(gameIdsToSearch)")
        guard let newURL = Endpoint.searchForIds(geekSite: .boardGame, idString: gameIdsToSearch).url else {
            // TODO: ERROR
            throw CustomErrors.wrongSearchURL
        }
        
        let (gamesData, _) = try await URLSession.shared.data(from: newURL)
        guard let gamesXMLString = String(data: gamesData, encoding: .utf8) else {
            // TODO: Error
            throw CustomErrors.wrongDataFromSearch
        }
        let gameXMLHash = XMLHash.parse(gamesXMLString)
        let boardGames: [BGGThing] = try gameXMLHash["items"]["item"].value()
        print("🦄 boardGames are \(boardGames)")
        return boardGames
    }
}

extension BoardGame: XMLObjectDeserialization {
    public static func deserialize(_ node: XMLIndexer) throws -> BoardGame {
        return try BoardGame(id: node.value(ofAttribute: "id"),
                             titles: node["name"].value(),
                             mainTitle:  node["name"].filterAll {
            elem, _ in elem.attribute(by: "type")?.text == "primary"
        }.value(ofAttribute: "value"))
    }
}

extension BGGThing: XMLObjectDeserialization {
    public static func deserialize(_ node: XMLIndexer) throws -> BGGThing {
        guard let type: String = node.value(ofAttribute: "type") else {
            // TODO: erro
            throw CustomErrors.wrongDataFromSearch
        }
        
        switch type {
        case "boardgame":
            return try .boardGame(.deserialize(node))
            // TODO: other cases
        default:
            // TODO Errors
            throw CustomErrors.wrongDataFromSearch
        }
//        return try BGGResponseItem(
//            id: node.value(ofAttribute: "id"),
//            name: node["name"].value(ofAttribute: "value"),
//            yearPublished: node["yearpublished"].value(ofAttribute: "value")
//            )
    }
}

struct BGGResponseItem: XMLObjectDeserialization {
    let id: Int
    let name: String
    let yearPublished: Int
    
    static func deserialize(_ node: XMLIndexer) throws -> BGGResponseItem {
           return try BGGResponseItem(
               id: node.value(ofAttribute: "id"),
               name: node["name"].value(ofAttribute: "value"),
               yearPublished: node["yearpublished"].value(ofAttribute: "value")
               )
       }
}
