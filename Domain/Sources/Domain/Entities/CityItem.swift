//
//  CityItem.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//
import Foundation

public struct CityItem {
    
    public let id: Int
    public let cityName: String
    public let latitude: Double
    public let longitude: Double

    public init(
        id: Int,
        cityName: String,
        latitude: Double,
        longitude: Double
    ) {
        self.id = id
        self.cityName = cityName
        self.latitude = latitude
        self.longitude = longitude
    }
}
