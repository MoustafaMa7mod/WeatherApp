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

    enum CodingKeys: String, CodingKey {
        case currentWeatherInfo = "current"
        case location
    }
    
    public func toDomain() -> WeatherItem {
        WeatherItem(
            cityName: location?.name ?? "",
            temperatureCelsiusDegree: currentWeatherInfo?.tempCelsius ?? 0,
            temperatureFahrenheitDegree: currentWeatherInfo?.tempFahrenheit ?? 0,
            humidity: currentWeatherInfo?.humidity ?? 0,
            windSpeed: currentWeatherInfo?.windSpeed ?? 0,
            weatherCondition: currentWeatherInfo?.condition?.description ?? "",
            icon: currentWeatherInfo?.condition?.icon ?? ""
        )
    }
}

/// Maps the object from `WeatherInfoEntity` to `WeatherItem` .
extension WeatherInfoEntity {
    
    func toDTO() -> WeatherItem? {
        nil
//        WeatherItem(
//            id: id,
//            cityName: cityName ?? "",
//            temperatureCelsiusDegree: temperatureDegree,
//            humidity: Int(humidity),
//            windSpeed: windSpeed,
//            weatherCondition: weatherCondition ?? "",
//            icon: icon ?? ""
//        )
    }
}
