//
//  File.swift
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
