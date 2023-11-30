//
//  File.swift
//  
//
//  Created by Trey on 11/9/23.
//

import Foundation
import BGGDemoUtilities

// Service for getting/searching/storing DataObjects used in the BGG app
public protocol BGGDemoRepositoryService {
    func bggItems(from geekSite: GeekSite, forSearchQuery query: String, withStats: Bool) async throws -> [BGGThing]
    func bggItem(forId id: Int) async throws -> BGGThing?
}
