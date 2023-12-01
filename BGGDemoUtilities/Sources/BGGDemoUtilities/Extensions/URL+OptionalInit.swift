//
//  URL+OptionalInit.swift
//
//
//  Created by Trey on 12/1/23.
//

import Foundation

public extension URL {
    init?(string: String?) {
        guard let string else {
            return nil
        }
        
        self.init(string: string)
    }
}
