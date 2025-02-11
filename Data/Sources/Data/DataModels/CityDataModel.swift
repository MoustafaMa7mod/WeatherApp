//
//  CityDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Domain

public struct CityDataModel: Codable {
    
    let id: Int
    let name: String?
    let latitude: Double?
    let longitude: Double?

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case name, id
    }
    
    public func toDomain() -> CityItem {
        CityItem(
            id: id,
            cityName: name ?? "",
            latitude: latitude ?? 0,
            longitude: longitude ?? 0
        )
    }
}
