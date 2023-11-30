//
//  String+Extensions.swift
//  BGGDemo
//
//  Created by Trey on 11/9/23.
//

import Foundation

extension String {
    init?(htmlEncodedString: String?) {
        guard let htmlEncodedString else {
            return nil
        }

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        self.init(attributedString.string)
    }
}
