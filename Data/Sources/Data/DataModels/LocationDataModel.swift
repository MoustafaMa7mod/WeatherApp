//
//  LocationDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 11/02/2025.
//

struct LocationDataModel: Codable {
    
    let name: String?
    let latitude: Double?
    let longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "lon"
    }
}
