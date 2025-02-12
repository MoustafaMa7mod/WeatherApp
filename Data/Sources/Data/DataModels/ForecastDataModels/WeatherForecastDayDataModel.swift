//
//  WeatherForecastDayDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain

public struct WeatherForecastDayDataModel: Codable {
    
    let maxTempCelsius: Double?
    let maxTempFahrenheit: Double?
    let minTempCelsius: Double?
    let minTempFahrenheit: Double?
    let condition: WeatherConditionDataModel?
    
    public init(
        maxTempCelsius: Double? = nil,
        maxTempFahrenheit: Double? = nil,
        minTempCelsius: Double? = nil,
        minTempFahrenheit: Double? = nil,
        condition: WeatherConditionDataModel? = nil
    ) {
        self.maxTempCelsius = maxTempCelsius
        self.maxTempFahrenheit = maxTempFahrenheit
        self.minTempCelsius = minTempCelsius
        self.minTempFahrenheit = minTempFahrenheit
        self.condition = condition
    }
    
    enum CodingKeys: String, CodingKey {
        case condition
        case maxTempCelsius = "maxtemp_c"
        case maxTempFahrenheit = "maxtemp_f"
        case minTempCelsius = "mintemp_c"
        case minTempFahrenheit = "mintemp_f"
    }
}
