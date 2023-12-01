//
//  BGGDemoApp.swift
//  BGGDemo
//
//  Created by Trey on 10/24/23.
//

import SwiftUI
import SwiftData
import BGGDemoRepositories

@main
struct BGGDemoApp: App {
    var repo: BGGDemoRepositoryService
    let modelContainer: ModelContainer
    init() {
        do {
            let schema = Schema([
                BoardGameDataObject.self,
                BoardGameExpansionDataObject.self
                // TODO: Add in user collection data object
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            repo = BGGDemoRepositories(modelContext: modelContainer.mainContext)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//            BoardGameDataObject.self,
//            BoardGameExpansionDataObject.self
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            MainTabView(repo: repo)
        }
//        .modelContainer(modelContainer)
    }
}


