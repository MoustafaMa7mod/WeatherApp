//
//  SearchView.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import SwiftUI

struct SearchView: View {

    @StateObject var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel) // Initialize viewModel
        CustomNavigationBar.setupAppearance()
    }

    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color
                    .appBlue
                    .ignoresSafeArea()
                
                List(viewModel.items, id: \.id) { item in
                    let weatherDetailsViewModel = viewModel.initialViewModel(
                        latitude: "\(item.latitude)",
                        longitude: "\(item.longitude )")
                    
                    NavigationLink(
                        destination: WeatherDetailsView(
                            viewModel: weatherDetailsViewModel
                        )
                    ) {
                        HStack(alignment: .center, spacing: 4) {
                            Text(item.countryName)
                                .font(.system(size: 18))
                            
                            Spacer()
                            
                            Image(systemName: "info.circle")
                                .foregroundColor(.white)
                        }
                        
                    }
                    .listRowBackground(Color.darkAppBlue)
                }
                .padding(.top, 4)
                .scrollContentBackground(.hidden)
                .background(.clear)
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.cityName, prompt: "Search")
        }
    }
}
