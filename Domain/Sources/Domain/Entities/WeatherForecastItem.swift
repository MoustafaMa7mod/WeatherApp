//
//  WeatherForecastItem.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

public struct WeatherForecastItem {
    
    public let date: String
    public let maxTemperatureCelsiusDegree: Double
    public let maxTemperatureFahrenheitDegree: Double
    public let minTemperatureCelsiusDegree: Double
    public let minTemperatureFahrenheitDegree: Double
    public let icon: String

    public init(
        date: String,
        maxTemperatureCelsiusDegree: Double,
        maxTemperatureFahrenheitDegree: Double,
        minTemperatureCelsiusDegree: Double,
        minTemperatureFahrenheitDegree: Double,
        icon: String
    ) {
        self.date = date
        self.maxTemperatureCelsiusDegree = maxTemperatureCelsiusDegree
        self.maxTemperatureFahrenheitDegree = maxTemperatureFahrenheitDegree
        self.minTemperatureCelsiusDegree = minTemperatureCelsiusDegree
        self.minTemperatureFahrenheitDegree = minTemperatureFahrenheitDegree
        self.icon = icon

    }
}
