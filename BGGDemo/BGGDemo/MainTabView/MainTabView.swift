//
//  MainTabView.swift
//  BGGDemo
//
//  Created by Trey on 10/26/23.
//

import SwiftUI
import BGGDemoRepositories
import SwiftData

struct MainTabView: View {
    var repo: BGGDemoRepositoryService
    var body: some View {
        TabView {
            BGGSearchView(viewModel: BGGSearchViewModel(repo: repo))
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            BGGUserCollectionView(repo: repo)
                .tabItem {
                    Label("Collection", systemImage: "archivebox")
                }
            // TODO: add settings tab?
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: BoardGameDataObject.self, configurations: .init(for: BoardGameDataObject.self, isStoredInMemoryOnly: true))
    return MainTabView(repo:  BGGDemoRepositories(modelContext: container.mainContext))
}
