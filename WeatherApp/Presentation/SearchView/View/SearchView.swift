//
//  SearchView.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import SwiftUI

struct SearchView: View {

    @State private var selectedItem: CountryItemPresentationModel?
    @State private var isNavigating = false

    @StateObject var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        CustomNavigationBar.setupAppearance()
    }

    var body: some View {
        
        NavigationView {

            ZStack {
                Color
                    .appBlue
                    .ignoresSafeArea()
                
                List(viewModel.items, id: \.id) { item in
                    HStack(alignment: .center, spacing: 4) {
                        Text(item.countryName)
                            .font(.system(size: 18))
                        
                        Spacer()
                        
                        Image(systemName: "info.circle")
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        selectedItem = item
                        isNavigating = true
                    }
                    .listRowBackground(Color.darkAppBlue)
                }
                .padding(.top, 4)
                .scrollContentBackground(.hidden)
                .background(.clear)

            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.cityName, prompt: "Search")
            .background(
                NavigationLink(
                    destination: destinationView(),
                    isActive: $isNavigating
                ) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }
    
    @ViewBuilder
    private func destinationView() -> some View {
        if let selectedItem {
            let weatherDetailsViewModel = viewModel.initialViewModel(
                latitude: "\(selectedItem.latitude)",
                longitude: "\(selectedItem.longitude )"
            )
            
            WeatherDetailsView(viewModel: weatherDetailsViewModel)
        } else {
            EmptyView()
        }
    }
}
