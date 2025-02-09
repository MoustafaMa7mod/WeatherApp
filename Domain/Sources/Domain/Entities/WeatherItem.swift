//
//  WeatherItem.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

public struct WeatherItem: Identifiable {
    
    public let id: Int
    public let cityName: String
    public let temperatureDegree: Double
    public let humidity: Int
    public let windSpeed: Double
    public let weatherCondition: String
    public let icon: String

    public init(
        id: Int,
        cityName: String,
        temperatureDegree: Double,
        humidity: Int,
        windSpeed: Double,
        weatherCondition: String,
        icon: String
    ) {
        self.id = id
        self.cityName = cityName
        self.temperatureDegree = temperatureDegree
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.weatherCondition = weatherCondition
        self.icon = icon
    }
}
