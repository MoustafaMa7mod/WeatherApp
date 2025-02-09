//
//  SearchView.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import SwiftUI

struct SearchView: View {

    @State private var results: [String] = [] // Start with an empty list
    @State private var cityName: String = ""
    
    init() {
        CustomNavigationBar.setupAppearance()
    }

    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color
                    .appBlue
                    .ignoresSafeArea()
                
                List(results, id: \.self) { item in
                    Text(item)
                }
                .background(Color.clear)
            }
            .navigationTitle("Search")
            .searchable(text: $cityName, prompt: "Search")
            .onChange(of: cityName) { newValue in
                //                fetchResults(for: newValue)
            }
        }
    }
}
