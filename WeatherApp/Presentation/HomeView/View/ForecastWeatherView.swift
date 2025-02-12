//
//  Untitled.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import SwiftUI
import Kingfisher

struct ForecastWeatherView: View {
    
    var item: ForecastItemsPresentationModel
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 8) {
          
            HStack(alignment: .center, spacing: 4) {
                
                Text(item.dayTitle)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color.darkAppBlue)
                
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
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                minTemperature
                maxTemperature
            }
        }
    }
    
    var minTemperature: some View {
        
        HStack(alignment: .center, spacing: 4) {
            
            Text("Min: ")
                .font(.system(size: 18, weight: .light))
                .foregroundColor(Color.darkAppBlue)
            
            Text(item.minTemperatureDegree)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Color.appOrange)
        }
    }
    
    var maxTemperature: some View {
        
        HStack(alignment: .center, spacing: 4) {
            
            Text("Max: ")
                .font(.system(size: 18, weight: .light))
                .foregroundColor(Color.darkAppBlue)
            
            Text(item.maxTemperatureDegree)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Color.appOrange)
        }
    }
}
