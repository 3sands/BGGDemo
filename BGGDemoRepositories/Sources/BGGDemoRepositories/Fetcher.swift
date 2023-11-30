//
//  File.swift
//  
//
//  Created by Trey on 11/9/23.
//

import BGGDemoUtilities
import Foundation
import SwiftData

protocol Fetcher {
//    associatedtype DataObject: HasBGGThing & PersistentModel
    
    func fetch(modelContext: ModelContext, id: Int) -> BGGThing?
}

//extension Fetcher {
//    associatedtype DataObject: HasBGGThing & PersistentModel\
//
//     THIS IMPLEMENTATION WITH AN ASSOCIATED TYPE CAUSES A CRASH
//     WHILE THE IMPLEMENTATION OF EACH STRUCT WITH ITS OWN `fetch`
//     DOES WORK. AND I CANNOT FIGURE OUT WHY YET. MAYBE A BUG?
//
//    func fetch(modelContext: ModelContext, id: Int) -> BGGThing? {
//        let temp = #Predicate<DataObject> { dataObject in
//            dataObject.bggId == localId
//        }
//        let descriptor = FetchDescriptor<DataObject>(predicate: temp)
//
//        // and also add in a last updated date check, so if stale, then update
//        
//        do {
//            let fetchedObject = try modelContext.fetch(descriptor)
//            
//            return fetchedObject.first?.bggThing
//        } catch {
//            return nil
//        }
//
//    }
//}

struct BoardGameFetcher: Fetcher {
//    typealias DataObject = BoardGameDataObject
    
    func fetch(modelContext: ModelContext, id: Int) -> BGGThing? {
        let temp = #Predicate<BoardGameDataObject> { dataObject in
            dataObject.bggId == id
        }
        let descriptor = FetchDescriptor<BoardGameDataObject>(predicate: temp)
        
        // and also add in a last updated date check, so if stale, then update
        do {
            let fetchedObject = try modelContext.fetch(descriptor)

            return fetchedObject.first?.bggThing
        } catch {
            return nil
        }

    }
}

struct BoardGameExpansionFetcher: Fetcher {
//    typealias DataObject = BoardGameExpansionDataObject
    
    func fetch(modelContext: ModelContext, id: Int) -> BGGThing? {
        let temp = #Predicate<BoardGameExpansionDataObject> { dataObject in
            dataObject.bggId == id
        }
        let descriptor = FetchDescriptor<BoardGameExpansionDataObject>(predicate: temp)
        
        // TODO: and also add in a last updated date check, so if stale, then update
        
        do {
            let fetchedObject = try modelContext.fetch(descriptor)
            
            return fetchedObject.first?.bggThing
        } catch {
            return nil
        }

    }
}
