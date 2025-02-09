//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//
import SwiftUI

struct WeatherDetailsView: View {
    
    @StateObject var viewModel: WeatherDetailsViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBlue)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Back Button (Leading)
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                        Text("Back")
                            .foregroundColor(.white)
                    }
                }
            }
            
            // Favorite Button on the Trailing Side
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    print("Trailing button tapped") // Add your action here
                }) {
                    Image(systemName: "ellipsis.circle") // Example trailing button
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    @ViewBuilder
    var content: some View {
        if let weatherComponentViewModel = viewModel.weatherComponentViewModel {
            
            WeatherComponentView(viewModel: weatherComponentViewModel)
        }
    }
}
