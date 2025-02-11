//
//  WeatherItemPresentationModel.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Domain
import SwiftUI

struct WeatherItemPresentationModel: Identifiable {
 
    private let temperature: Double
    private let humidity: Int
    private let speed: Double
    private let icon: String
    
    let id: Int
    let weatherCondition: String
    let cityName: String
    
    var weatherIcon: URL? {
        URL(string: "\(ConfigurationManager.shared.imageUrl)\(icon).png")
    }
    
    var windSpeed: String {
        "\(speed) km/h"
    }
    
    var weatherHumidity: String {
        "\(humidity)%"
    }
    
    var temperatureDegree: String {
        "\(temperature.getTemperature())"
    }

    init(model: WeatherItem) {
        
        self.id = model.id
        self.cityName = model.cityName
        self.temperature = model.temperatureDegree
        self.humidity = model.humidity
        self.speed = model.windSpeed
        self.weatherCondition = model.weatherCondition
        self.icon = model.icon
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
