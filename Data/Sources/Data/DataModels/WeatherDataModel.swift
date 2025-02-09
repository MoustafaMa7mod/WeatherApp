//
//  WeatherDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation
import Domain

public struct WeatherDataModel: Codable {
    
    let id: Int
    let name: String?
    let weather: [WeatherConditionDataModel]?
    let windSpeed: WindSpeedDataModel?
    let temperature: TemperatureDataModel?

    enum CodingKeys: String, CodingKey {
        case temperature = "main"
        case windSpeed = "wind"
        case id, name, weather
    }
    
    public func toDomain() -> WeatherItem {
        WeatherItem(
            id: id,
            cityName: name ?? "",
            temperatureDegree: temperature?.degree ?? 0,
            humidity: temperature?.humidity ?? 0,
            windSpeed: windSpeed?.speed ?? 0,
            weatherCondition: weather?.first?.description ?? "",
            icon: weather?.first?.icon ?? ""
        )
    }
}
