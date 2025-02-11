//
//  FavoritesView.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import SwiftUI
import Kingfisher

struct FavoritesView: View {

    @StateObject var viewModel: FavoritesViewModel

    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                ForEach(viewModel.weatherItemPresentationModel, id: \.id) { item in
                    
                    HStack(alignment: .center, spacing: 4) {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            
                            HStack(alignment: .center, spacing: 4) {
                                Text(item.cityName)
                                    .font(.system(size: 18))
                                    .foregroundColor(Color.black)
                                
                                Text(item.temperatureDegree)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(Color.darkAppBlue)
                            }
                            
                            HStack(alignment: .center, spacing: 4) {
                                
                                if let weatherIcon = item.weatherIcon {
                                    
                                    KFImage(weatherIcon)
                                        .placeholder {
                                            ProgressView()
                                        }
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 25, height: 25)
                                }
                                
                                Text(item.weatherCondition)
                                    .font(.system(size: 18, weight: .light))
                                    .foregroundColor(Color.darkAppBlue)
                            }
                            
                            HStack(alignment: .center, spacing: 16) {
                                
                                HStack(alignment: .center, spacing: 4) {
                                    Image("humidity")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                    
                                    Text(item.weatherHumidity)
                                        .font(.system(size: 18, weight: .light))
                                        .foregroundColor(Color.darkAppBlue)
                                }
                                
                                HStack(alignment: .center, spacing: 4) {
                                    Image("wind")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                    
                                    Text(item.windSpeed)
                                        .font(.system(size: 18, weight: .light))
                                        .foregroundColor(Color.darkAppBlue)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.removeCityFromFavorites(id: item.cityID)
                        }) {
                            Image("favorite")
                                .resizable()
                                .scaledToFit()
                                .tint(.red)
                                .frame(width: 24, height: 24)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .onAppear {
                    viewModel.onAppear()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(Color.appBlue)
            .navigationTitle("Favorites")
        }
    }
}

