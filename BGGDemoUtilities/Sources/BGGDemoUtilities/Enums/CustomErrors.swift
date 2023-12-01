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
    case userCollectionRetry
    case userCollectionFailed
}
