//
//  File.swift
//  
//
//  Created by Trey on 10/26/23.
//

import Foundation

/// BGG Search Response returns only a small amount of data for each item
struct BGGSearchResponseItem {
    let id: Int
    let name: String
    let yearPublished: Int?
}
