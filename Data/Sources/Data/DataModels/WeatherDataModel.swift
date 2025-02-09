//
//  WeatherDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation

public struct WeatherDataModel: Codable {
    
    let id: Int
    let name: String?
    let weather: WeatherConditionDataModel?
    let windSpeed: WindSpeedDataModel?
    let temperature: TemperatureDataModel?

//    public func toDomain() -> BusinessItem {
//        return BusinessItem(id: id,
//                            slug: slug ?? "",
//                            name: name ?? "",
//                            logo: logo ?? "")
//    }
}
