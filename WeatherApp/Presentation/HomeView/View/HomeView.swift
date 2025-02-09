//
//  HomeView.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBlue)
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    var content: some View {
        if let item = viewModel.weatherItemPresentationModel {
         
            VStack(alignment: .center, spacing: 16) {
                if let weatherIcon = item.weatherIcon {
                    KFImage(weatherIcon)
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                }
                
                HStack(alignment: .center) {
                    Text("Description")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .opacity(0.65)

                    Spacer()
                    Text(item.weatherCondition)
                        .font(.system(size: 18))
                        .foregroundColor(Color.darkAppBlue)
                }
                .padding(.horizontal, 12)
                
                HStack(alignment: .center) {
                    Text("Temperature")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .opacity(0.65)

                    Spacer()
                    Text(item.temperatureDegree)
                        .font(.system(size: 18))
                        .foregroundColor(Color.darkAppBlue)
                }
                .padding(.horizontal, 12)

                HStack(alignment: .center) {
                    Text("Humidity")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .opacity(0.65)

                    Spacer()
                    Text(item.weatherHumidity)
                        .font(.system(size: 18))
                        .foregroundColor(Color.darkAppBlue)
                }
                .padding(.horizontal, 12)

                HStack(alignment: .center) {
                    Text("Wind Speed")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .opacity(0.65)

                    Spacer()
                    Text(item.windSpeed)
                        .font(.system(size: 18))
                        .foregroundColor(Color.blue)
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 24)
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding(24)
        }
    }
}
