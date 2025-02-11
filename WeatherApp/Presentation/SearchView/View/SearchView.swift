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
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    ForEach(viewModel.items, id: \.id) { item in
                        
                        HStack(alignment: .center, spacing: 4) {
                            Text(item.cityName)
                                .foregroundColor(Color.black)
                                .font(.system(size: 18))
                            
                            Spacer()
                            
                            Image(systemName: "info.circle")
                                .foregroundColor(Color.darkAppBlue)
                        }
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            selectedItem = item
                            isNavigating = true
                        }
                    }
                }
                .padding(12)
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
    }
    
    @ViewBuilder
    private func destinationView() -> some View {
        if let selectedItem {
            let weatherDetailsViewModel = viewModel.initialViewModel(
                cityName: "\(selectedItem.cityName)",
                cityID: selectedItem.id
            )
            
            WeatherDetailsView(viewModel: weatherDetailsViewModel)
        } else {
            EmptyView()
        }
    }
}
