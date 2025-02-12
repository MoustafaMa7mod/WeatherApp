//
//  MockWeatherRepository.swift
//  Data
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Foundation
import Data

extension MockWeatherRemoteAPI {
    
    func weatherDataModel() -> WeatherDataModel {
        let condition = WeatherConditionDataModel(
            description: "Clear",
            icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"
        )
        
        let currentWeatherInfo = CurrentWeatherDataModel(
            tempCelsius: 12.2,
            tempFahrenheit: 54.0,
            humidity: 77,
            windSpeed: 9.7,
            condition: condition
        )
        
        let weatherForecastDayDataModel = WeatherForecastDayDataModel(
            maxTempCelsius: 18.4,
            maxTempFahrenheit: 65.1,
            minTempCelsius: 9.9,
            minTempFahrenheit: 49.8,
            condition: condition
        )
        
        let forecastDayDataModel = [
            ForecastDayDataModel(
                date: "2025-02-12",
                day: weatherForecastDayDataModel
            ),
            ForecastDayDataModel(
                date: "2025-02-13",
                day: weatherForecastDayDataModel
            )
        ]
        let forecast = ForecastDataModel(forecastDay: forecastDayDataModel)
        
        return WeatherDataModel(
            location: LocationDataModel(name: "Giza"),
            currentWeatherInfo: currentWeatherInfo,
            forecast: forecast
        )
    }
}
