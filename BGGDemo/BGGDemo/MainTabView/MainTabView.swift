//
//  MainTabView.swift
//  BGGDemo
//
//  Created by Trey on 10/26/23.
//

import SwiftUI
import BGGDemoRepositiories
import SwiftData

struct MainTabView: View {
    var repo: BGGDemoRepositiories
//    @Environment(\.modelContext) private var modelContext
    var body: some View {
        TabView {
            BGGSearchView(viewModel: BGGSearchViewModel(repo: repo))
                .badge(2)
                .tabItem {
                    Label("Received", systemImage: "tray.and.arrow.down.fill")
                }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: BoardGameDataObject.self, configurations: .init(for: BoardGameDataObject.self, isStoredInMemoryOnly: true))
    return MainTabView(repo:  .init(modelContext: container.mainContext))

//        .modelContainer(for: Item.self, inMemory: true)
}
