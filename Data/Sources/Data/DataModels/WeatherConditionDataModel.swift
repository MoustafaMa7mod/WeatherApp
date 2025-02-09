//
//  WeatherConditionDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

struct WeatherConditionDataModel: Codable {
    
    let id: Int
    let title: String?
    let description: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case title = "main"
        case id, description, icon
    }
}
