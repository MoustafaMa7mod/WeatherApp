//
//  TabbarView.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import SwiftUI

struct TabbarView: View {

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                FavouritesView()
                    .tabItem {
                        Label("Favourites", systemImage: "heart.fill")
                    }
                
                SettingView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    TabbarView()
}
