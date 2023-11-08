//
//  File.swift
//  
//
//  Created by Trey on 10/26/23.
//

import Foundation

public struct PlayersNumber {
    public let minimum: Int?
    public let maximum: Int?
    
    public init(minimum: Int?, maximum: Int?) {
        self.minimum = minimum
        self.maximum = maximum
    }
}
