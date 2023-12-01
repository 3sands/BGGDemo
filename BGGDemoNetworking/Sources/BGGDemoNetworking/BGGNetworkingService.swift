//
//  BGGNetworkingService.swift
//
//
//  Created by Trey on 12/1/23.
//

import BGGDemoUtilities
import Foundation

public protocol BGGNetworkingService {
    func search(geeksite: GeekSite, forIds ids: [Int], withStats: Bool) async throws -> [BGGThing]
    func search(geeksite: GeekSite, forQuery query: String) async throws -> BGGSearchResponse
    func retrieveUserCollection(geeksite: GeekSite, forUserName userName: String) async throws -> UserCollection
}
