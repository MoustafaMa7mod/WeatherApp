//
//  TemperatureDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

struct TemperatureDataModel: Codable {
    
    let temperature: Double?
    let humidity: Double?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
    }
}
