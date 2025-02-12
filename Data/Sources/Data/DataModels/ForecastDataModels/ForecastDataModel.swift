//
//  ForecastDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

public struct ForecastDataModel: Codable {
    
    let forecastDay: [ForecastDayDataModel]?
    
    public init(forecastDay: [ForecastDayDataModel]? = nil) {
        self.forecastDay = forecastDay
    }
}
