//
//  Endpoint.swift
//  
//
//  Created by Trey on 10/25/23.
//

import Foundation
import BGGDemoUtilities

struct Endpoint {
    let geekSite: GeekSite
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    static func search(geekSite: GeekSite, 
                       query: String) -> Endpoint {
        return Endpoint(
            geekSite: geekSite,
            path: "/xmlapi2/search/",
            queryItems: [
                URLQueryItem(name: "query", value: query)
            ]
        )
    }
    
    static func searchForIds(geekSite: GeekSite,
                             idString: String,
                             withStats: Bool) -> Endpoint {
        return Endpoint(
            geekSite: geekSite,
            path: "/xmlapi2/thing",
            queryItems: [
                URLQueryItem(name: "id", value: idString),
                URLQueryItem(name: "stats", value: withStats ? "1" : nil)
            ]
        )
    }
    
    static func userCollection(geekSite: GeekSite,
                               userName: String,
                               withExpansions: Bool) -> Endpoint {
        // FROM BGG: Note that the default (or using subtype=boardgame) returns both boardgame and boardgameexpansion's in your collection...
        // but incorrectly gives subtype=boardgame for the expansions. Workaround is to use excludesubtype=boardgameexpansion and
        // make a 2nd call asking for subtype=boardgameexpansion
        let expansionQueryItemName = withExpansions ? "subtype" : "excludesubtype"

        return Endpoint(geekSite: geekSite,
                        path: "/xmlapi2/collection",
                        queryItems: [
                            URLQueryItem(name: "username", value: userName),
                            URLQueryItem(name: expansionQueryItemName, value: "boardgameexpansion"),
                            URLQueryItem(name: "stats", value: "1")
                        ])
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = geekSite.host
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}

extension GeekSite {
    var host: String {
        switch self {
        case .boardGame: return "boardgamegeek.com"
        case .rpg: return "rpggeek.com"
        case .videoGame: return "videogamegeek.com"
        }
    }
}
