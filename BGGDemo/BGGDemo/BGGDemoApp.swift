//
//  BGGDemoApp.swift
//  BGGDemo
//
//  Created by Trey on 10/24/23.
//

import SwiftUI
import SwiftData

@main
struct BGGDemoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            BGGSearchView(viewModel: BGGSearchViewModel())
        }
        .modelContainer(sharedModelContainer)
    }
}
