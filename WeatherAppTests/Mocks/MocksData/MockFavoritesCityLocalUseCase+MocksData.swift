//
//  MocksData.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain

extension MockFavoritesCityLocalUseCase {
    
    func weatherItemsModel() -> [WeatherItem] {
        [
            WeatherItem(
                cityID: 686859,
                cityName: "Giza",
                temperatureCelsiusDegree: 12.2,
                temperatureFahrenheitDegree: 54.0,
                humidity: 77,
                windSpeed: 9.7,
                weatherCondition: "Clear",
                icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"
            ),
            WeatherItem(
                cityID: 2801268,
                cityName: "London",
                temperatureCelsiusDegree: 5.0,
                temperatureFahrenheitDegree: 41.0,
                humidity: 87,
                windSpeed: 7.2,
                weatherCondition: "Partly cloudy",
                icon: "//cdn.weatherapi.com/weather/64x64/night/116.png"
            )
        ]
    }
}
