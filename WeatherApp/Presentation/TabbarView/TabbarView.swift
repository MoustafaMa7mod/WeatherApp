//
//  TabbarView.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import SwiftUI

struct TabbarView: View {

    let factory: WeatherFactory
    
    init() {
        factory = DefaultWeatherFactory()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            TabView {
                HomeView(viewModel: HomeViewModel(useCase: factory.makeGetWeatherUseCase()))
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
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
