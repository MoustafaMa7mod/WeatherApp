//
//  HomeView.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .center, spacing: 0) {
                content
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBlue)
            .navigationTitle("Home")
        }
    }
    
    @ViewBuilder
    var content: some View {
        if let weatherComponentViewModel = viewModel.weatherComponentViewModel {
            
            WeatherComponentView(viewModel: weatherComponentViewModel)
        }
    }
}
