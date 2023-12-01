//
//  CustomErrors.swift
//  
//
//  Created by Trey on 10/25/23.
//

import Foundation

public enum CustomErrors: Error {
    case cannotConvertSearchResultIntoXMLString
    case cannotConvertSearchIdsResultIntoXMLString
    case wrongSearchURL
    case missingSearchForQueryURL
    case missingSearchForIdsURL
    case wrongDataFromSearch
    case cannotGetTypeFromXML
    case missingUserNameURL
    case userCollectionFailed
    case bggProvidedError(String)
    
    public var displayText: String {
        switch self {
        case .cannotConvertSearchResultIntoXMLString:
            return "Cannot convert search result"
        case .cannotConvertSearchIdsResultIntoXMLString:
            return "Cannot convert search ids result"
        case .wrongSearchURL:
            return "Wrong search URL"
        case .missingSearchForQueryURL:
            return "Missing search for query URL"
        case .missingSearchForIdsURL:
            return "Missing search for IDs URL"
        case .wrongDataFromSearch:
            return "Wrong data from Search"
        case .cannotGetTypeFromXML:
            return "Cannot get type from XML"
        case .missingUserNameURL:
            return "Missing username URL"
        case .userCollectionFailed:
            return "User Collection Failed"
        case .bggProvidedError(let errorMessage):
            return errorMessage
        }
    }
}
