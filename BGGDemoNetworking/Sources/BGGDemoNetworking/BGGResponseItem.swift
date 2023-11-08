//
//  File.swift
//  
//
//  Created by Trey on 10/26/23.
//

import Foundation

/// BGG Search Response returns only a small amount of data for each item
public struct BGGSearchResponseItem {
    public let id: Int
    public let name: String
    public let yearPublished: Int?
    public let type: String
}

public struct BGGSearchResponse {
    public let query: String
    public let items: [BGGSearchResponseItem]
}
