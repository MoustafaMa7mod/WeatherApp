//
//  CountryDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Domain

public struct CountryDataModel: Codable {
    
    let name: String?
    let latitude: Double?
    let longitude: Double?

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case name
    }
    
    public func toDomain() -> CountryItem {
        return CountryItem(
            cityName: name ?? "",
            latitude: latitude ?? 0,
            longitude: longitude ?? 0
        )
    }
}
