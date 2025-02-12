//
//  WeatherItemPresentationModel.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Domain
import SwiftUI

struct WeatherItemPresentationModel: Identifiable {
 
    private let humidity: Int
    private let speed: Double
    private let icon: String
    private let temperatureCelsiusDegree: Double
    private let temperatureFahrenheitDegree: Double

    let id: UUID
    let weatherCondition: String
    let cityName: String
    let cityID: Int
    let forecastItems: [ForecastItemsPresentationModel]
    
    var weatherIcon: URL? {
        URL(string: "https:\(icon)")
    }
    
    var windSpeed: String {
        "\(speed) km/h"
    }
    
    var weatherHumidity: String {
        "\(humidity)%"
    }
    
    var temperatureDegree: String {
        let isCelsius = UserDefaults.standard.object(
            forKey: Constants.UserDefaultsKeys.celsiusKey
        ) as? Bool ?? true
        
        let temp = isCelsius ? temperatureCelsiusDegree : temperatureFahrenheitDegree
        
        return String(format: "%.1f°%@", temp, isCelsius ? "C" : "F")
    }

    init(model: WeatherItem) {
        
        self.id = UUID()
        self.cityName = model.cityName ?? ""
        self.cityID = model.cityID ?? 0
        self.temperatureCelsiusDegree = model.temperatureCelsiusDegree
        self.temperatureFahrenheitDegree = model.temperatureFahrenheitDegree
        self.humidity = model.humidity
        self.speed = model.windSpeed
        self.weatherCondition = model.weatherCondition
        self.icon = model.icon
        self.forecastItems = model.forecastItems.map {
            ForecastItemsPresentationModel(model: $0 )
        }
    }
}

 // MARK: - Conform Equatable
extension WeatherItemPresentationModel: Equatable {

    static func == (
        lhs: WeatherItemPresentationModel,
        rhs: WeatherItemPresentationModel
    ) -> Bool {
        
        return lhs.id == rhs.id
    }
}
