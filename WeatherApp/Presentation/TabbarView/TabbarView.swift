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
        CustomTabbar.setupAppearance()
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            TabView {
                HomeView(
                    viewModel: HomeViewModel(useCase: factory.makeGetWeatherUseCase())
                )
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                
                SearchView(
                    viewModel: SearchViewModel(
                        searchCountryUseCase: factory.makeSearchWeatherUseCase(),
                        getWeatherUseCase: factory.makeGetWeatherUseCase()
                    )
                )
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
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
