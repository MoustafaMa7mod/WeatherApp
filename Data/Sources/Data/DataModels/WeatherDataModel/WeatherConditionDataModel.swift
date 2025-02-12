//
//  WeatherConditionDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

public struct WeatherConditionDataModel: Codable {
    
    let description: String?
    let icon: String?

    public init(description: String? = nil, icon: String? = nil) {
        self.description = description
        self.icon = icon
    }
    
    enum CodingKeys: String, CodingKey {
        case description = "text"
        case icon
    }
}
