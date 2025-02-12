//
//  WeatherItem.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation

public struct WeatherItem {
    
    public let cityID: Int?
    public let cityName: String?
    public let temperatureCelsiusDegree: Double
    public let temperatureFahrenheitDegree: Double
    public let humidity: Int
    public let windSpeed: Double
    public let weatherCondition: String
    public let icon: String
    public let forecastItems: [WeatherForecastItem]

    public init(
        cityID: Int? = nil,
        cityName: String? = nil,
        temperatureCelsiusDegree: Double,
        temperatureFahrenheitDegree: Double,
        humidity: Int,
        windSpeed: Double,
        weatherCondition: String,
        icon: String,
        forecastItems: [WeatherForecastItem] = []
    ) {
        self.cityID = cityID
        self.cityName = cityName
        self.temperatureCelsiusDegree = temperatureCelsiusDegree
        self.temperatureFahrenheitDegree = temperatureFahrenheitDegree
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.weatherCondition = weatherCondition
        self.icon = icon
        self.forecastItems = forecastItems
    }
}
