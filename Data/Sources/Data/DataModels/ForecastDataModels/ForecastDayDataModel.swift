//
//  ForecastDayDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain

public struct ForecastDayDataModel: Codable {
    
    let date: String?
    let day: WeatherForecastDayDataModel?
    
    public init(
        date: String? = nil,
        day: WeatherForecastDayDataModel? = nil
    ) {
        self.date = date
        self.day = day
    }
    
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
