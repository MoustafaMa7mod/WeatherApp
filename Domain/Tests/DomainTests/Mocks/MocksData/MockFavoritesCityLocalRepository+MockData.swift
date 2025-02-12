//
//  MockFavoritesCityLocalRepository.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain

extension MockFavoritesCityLocalRepository {
    
    func addedWeatherItem() -> WeatherItem {
        WeatherItem(
            cityID: 686859,
            cityName: "Giza",
            temperatureCelsiusDegree: 12.2,
            temperatureFahrenheitDegree: 54.0,
            humidity: 77,
            windSpeed: 9.7,
            weatherCondition: "Clear",
            icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"
        )
    }
    
    func weatherItemsModel() -> [WeatherItem] {
        [WeatherItem(
            cityID: 686859,
            cityName: "Giza",
            temperatureCelsiusDegree: 12.2,
            temperatureFahrenheitDegree: 54.0,
            humidity: 77,
            windSpeed: 9.7,
            weatherCondition: "Clear",
            icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"
        )]
    }
}
