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
    
    public init(id: Int, name: String? = nil) {
        self.id = id
        self.name = name
    }

    public func toDomain() -> CityItem {
        CityItem(
            id: id,
            cityName: name ?? ""
        )
    }
}
