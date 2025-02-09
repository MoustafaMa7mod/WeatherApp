//
//  WeatherComponentView.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Kingfisher
import SwiftUI

struct WeatherComponentView: View {
    
    @ObservedObject var viewModel: WeatherComponentViewModel
    
    init(viewModel: WeatherComponentViewModel) {
        self.viewModel = viewModel
    }
    
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
        
        VStack(alignment: .center, spacing: 12) {
            weatherInfo
            
            HStack(alignment: .center, spacing: 12) {
                
                weatherHumidity
                windSpeed
            }
        }
    }
    
    @ViewBuilder
    var weatherInfo: some View {
        
        if let item = viewModel.weatherItemPresentationModel {
           
            VStack(alignment: .center, spacing: 4) {
               
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
                
                Text(item.cityName)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                
                Text(item.temperatureDegree)
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(Color.darkAppBlue)
                
                Text(item.weatherCondition)
                    .font(.system(size: 40, weight: .light))
                    .foregroundColor(Color.darkAppBlue)
            }
        }
    }
    
    @ViewBuilder
    var weatherHumidity: some View {
        
        if let item = viewModel.weatherItemPresentationModel {
          
            VStack(alignment: .center, spacing: 8) {
                
                HStack(alignment: .center, spacing: 4) {
                    Image("humidity")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    Text("Humidity")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                        .opacity(0.65)
                    
                    
                }
                
                Text(item.weatherHumidity)
                    .font(.system(size: 18))
                    .foregroundColor(Color.darkAppBlue)
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
    }
    
    @ViewBuilder
    var windSpeed: some View {
        
        if let item = viewModel.weatherItemPresentationModel {
          
            VStack(alignment: .center, spacing: 8) {
                
                HStack(alignment: .center, spacing: 4) {
                    Image("wind")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    Text("Wind Speed")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                        .opacity(0.65)
                }
                
                Text(item.windSpeed)
                    .font(.system(size: 18))
                    .foregroundColor(Color.darkAppBlue)

            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
    }
}
