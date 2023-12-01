//
//  Playtime.swift
//
//
//  Created by Trey on 10/26/23.
//

import Foundation

public struct Playtime {
    public let minimum: Int?
    public let maximum: Int?
    public let average: Int?
    
    public init(minimum: Int?, maximum: Int?, average: Int?) {
        self.minimum = minimum
        self.maximum = maximum
        self.average = average
    }
}
