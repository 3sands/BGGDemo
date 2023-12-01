//
//  UserCollectionGameStatus.swift
//  
//
//  Created by Trey on 12/1/23.
//

import Foundation

public enum UserCollectionGameStatus: Int, Identifiable, CaseIterable {
    public var id: Int { rawValue }
    
    case own
    case previouslyOwned
    case forTrade
    case want
    case wantToPlay
    case wantToBuy
    case wishList
    case preordered
    case unknown
    
    public var codingKey: String {
        switch self {
        case .own:
            return "own"
        case .previouslyOwned:
            return "prevowned"
        case .forTrade:
            return "fortrade"
        case .want:
            return "want"
        case .wantToPlay:
            return "wanttoplay"
        case .wantToBuy:
            return "wanttobuy"
        case .wishList:
            return "wishlist"
        case .preordered:
            return "preordered"
        case .unknown:
            return ""
        }
    }
    
    // Should be localized but I don't have that budget
    public var displayString: String {
        switch self {
        case .own:
            return "Own"
        case .previouslyOwned:
            return "Previously Owned"
        case .forTrade:
            return "For Trade"
        case .want:
            return "Want"
        case .wantToPlay:
            return "Want to Play"
        case .wantToBuy:
            return "Want to Buy"
        case .wishList:
            return "Wishlist"
        case .preordered:
            return "Preordered"
        case .unknown:
            return "Unknown"
        }
    }
}
