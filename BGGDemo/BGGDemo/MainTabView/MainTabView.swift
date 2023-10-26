//
//  MainTabView.swift
//  BGGDemo
//
//  Created by Trey on 10/26/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            BGGSearchView(viewModel: BGGSearchViewModel())
                .badge(2)
                .tabItem {
                    Label("Received", systemImage: "tray.and.arrow.down.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}
