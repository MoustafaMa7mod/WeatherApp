//
//  WeatherConditionDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

struct WeatherConditionDataModel: Codable {
    
    let description: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case description = "text"
        case icon
    }
}
