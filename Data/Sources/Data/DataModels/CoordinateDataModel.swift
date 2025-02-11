//
//  CoordinateDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 10/02/2025.
//

struct CoordinateDataModel: Codable {
    
    let latitude: Double?
    let longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
