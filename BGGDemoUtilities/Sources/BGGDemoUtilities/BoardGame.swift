//
//  File.swift
//  
//
//  Created by Trey on 10/24/23.
//

import Foundation

/// Entity for a Board Game
public struct BoardGame: Identifiable {
    /// ID on BGG
    public let id: Int
    
    /// Titles on BGG
    public let titles: [String]
    
    /// Main title on BGG
    public let mainTitle: String
    
    public init(id: Int, 
                titles: [String],
                mainTitle: String) {
        self.id = id
        self.titles = titles
        self.mainTitle = mainTitle
    }
}
