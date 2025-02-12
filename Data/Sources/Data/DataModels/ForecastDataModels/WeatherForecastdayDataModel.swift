//
//  WeatherForecastdayDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain

struct WeatherForecastdayDataModel: Codable {
    
    let maxTempCelsius: Double?
    let maxTempFahrenheit: Double?
    let minTempCelsius: Double?
    let minTempFahrenheit: Double?
    let condition: WeatherConditionDataModel?
    
    enum CodingKeys: String, CodingKey {
        case condition
        case maxTempCelsius = "maxtemp_c"
        case maxTempFahrenheit = "maxtemp_f"
        case minTempCelsius = "mintemp_c"
        case minTempFahrenheit = "mintemp_f"
    }
}
