//
//  TemperatureDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

struct TemperatureDataModel: Codable {
    
    let degree: Double?
    let humidity: Double?
    
    enum CodingKeys: String, CodingKey {
        case degree = "temp"
        case humidity
    }
}
