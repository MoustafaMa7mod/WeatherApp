//
//  WeatherDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation
import Domain

public struct WeatherDataModel: Codable {
    
    let location: LocationDataModel?
    let currentWeatherInfo: CurrentWeatherDataModel?
    let forecast: ForecastDataModel?

    enum CodingKeys: String, CodingKey {
        case currentWeatherInfo = "current"
        case location, forecast
    }
    
    public func toDomain() -> WeatherItem {
        
        let forecastday = forecast?.forecastday ?? []
        let forecastItems = forecastday.map { $0.toDomain() }

        return WeatherItem(
            cityName: location?.name ?? "",
            temperatureCelsiusDegree: currentWeatherInfo?.tempCelsius ?? 0,
            temperatureFahrenheitDegree: currentWeatherInfo?.tempFahrenheit ?? 0,
            humidity: currentWeatherInfo?.humidity ?? 0,
            windSpeed: currentWeatherInfo?.windSpeed ?? 0,
            weatherCondition: currentWeatherInfo?.condition?.description ?? "",
            icon: currentWeatherInfo?.condition?.icon ?? "",
            forecastItems: forecastItems
        )
    }
}

/// Maps the object from `WeatherInfoEntity` to `WeatherItem` .
extension WeatherInfoEntity {
    
    func toDTO() -> WeatherItem {
        WeatherItem(
            cityID: Int(city?.id ?? 0),
            cityName: city?.name,
            temperatureCelsiusDegree: temperatureCelsiusDegree,
            temperatureFahrenheitDegree: temperatureCelsiusDegree,
            humidity: Int(humidity),
            windSpeed: windSpeed,
            weatherCondition: weatherCondition ?? "",
            icon: icon ?? ""
        )
    }
}
