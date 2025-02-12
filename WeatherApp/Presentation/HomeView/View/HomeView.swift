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
            
            if viewModel.isLoading {
                
                VStack(alignment: .center, spacing: 0) {
                    ProgressView()
                        .tint(Color.appOrange)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.appBlue)
                .navigationTitle("Home")
            } else {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .center, spacing: 12) {
                        
                        if let viewModel = viewModel.weatherComponentViewModel {
                            
                            weatherInfo(weatherComponentViewModel: viewModel)
                            weatherForecast(
                                items: viewModel.weatherItemPresentationModel?.forecastItems ?? []
                            )
                            .padding(12)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.appBlue)
                .navigationTitle("Home")
            }
        }
    }
    
    @ViewBuilder
    func weatherInfo(weatherComponentViewModel: WeatherComponentViewModel) -> some View {
        WeatherComponentView(viewModel: weatherComponentViewModel)
    }
    
    @ViewBuilder
    func weatherForecast(items: [ForecastItemsPresentationModel]) -> some View {
        
        if !items.isEmpty {
          
            VStack(alignment: .leading, spacing: 8) {
                
                Text("7-Day Forecast")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.darkAppBlue)
                divider
                
                ForEach(items, id: \.id) { item in
                    ForecastWeatherView(item: item)
                    divider
                }
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(Color.white)
            .cornerRadius(20)
        }
    }
    
    var divider: some View {
        
        Divider()
            .frame(height: 1)
            .background(Color.appOrange)
    }
}
