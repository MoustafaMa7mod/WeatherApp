//
//  LocationDataModel.swift
//  Data
//
//  Created by Mostafa Mahmoud on 11/02/2025.
//

public struct LocationDataModel: Codable {
    
    let name: String?
    
    public init(name: String? = nil) {
        self.name = name
    }
}
