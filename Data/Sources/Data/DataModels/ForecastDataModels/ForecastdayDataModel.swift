//
//  ForecastdayDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain

struct ForecastdayDataModel: Codable {
    
    let date: String?
    let day: WeatherForecastdayDataModel?
    
    public func toDomain() -> WeatherForecastItem {
        
        WeatherForecastItem(
            date: date ?? "",
            maxTemperatureCelsiusDegree: day?.maxTempCelsius ?? 0,
            maxTemperatureFahrenheitDegree: day?.maxTempFahrenheit ?? 0,
            minTemperatureCelsiusDegree: day?.minTempCelsius ?? 0,
            minTemperatureFahrenheitDegree: day?.minTempFahrenheit ?? 0,
            icon: day?.condition?.icon ?? ""
        )
    }
}
