//
//  CountryItem.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//
import Foundation

public struct CountryItem: Identifiable {
    
    public let id: UUID
    public let cityName: String
    public let latitude: Double?
    public let longitude: Double?

    public init(
        cityName: String,
        latitude: Double,
        longitude: Double
    ) {
        self.id = UUID()
        self.cityName = cityName
        self.latitude = latitude
        self.longitude = longitude
    }
}
