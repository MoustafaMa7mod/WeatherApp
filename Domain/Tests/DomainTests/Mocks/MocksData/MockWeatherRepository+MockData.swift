//
//  MockWeatherRepository+MockData.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain

extension MockWeatherRepository {
    
    func weatherItemModel() -> WeatherItem {
        
        let weatherForecastItem = [
                WeatherForecastItem(
                    date: "2025-02-12",
                    maxTemperatureCelsiusDegree: 18.4,
                    maxTemperatureFahrenheitDegree: 65.1,
                    minTemperatureCelsiusDegree: 9.9,
                    minTemperatureFahrenheitDegree: 49.8,
                    icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"
                ),
            WeatherForecastItem(
                date: "2025-02-13",
                maxTemperatureCelsiusDegree: 18.4,
                maxTemperatureFahrenheitDegree: 65.1,
                minTemperatureCelsiusDegree: 9.9,
                minTemperatureFahrenheitDegree: 49.8,
                icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"
            )
        ]
        
        return WeatherItem(
            cityID: 686859,
            cityName: "Giza",
            temperatureCelsiusDegree: 12.2,
            temperatureFahrenheitDegree: 54.0,
            humidity: 77,
            windSpeed: 9.7,
            weatherCondition: "Clear",
            icon: "//cdn.weatherapi.com/weather/64x64/night/113.png",
            forecastItems: weatherForecastItem
        )
    }
}
