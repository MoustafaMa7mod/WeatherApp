//
//  CountryItem.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//
import Foundation

public struct CountryItem {
    
    public let countryName: String
    public let latitude: Double
    public let longitude: Double

    public init(
        countryName: String,
        latitude: Double,
        longitude: Double
    ) {
        self.countryName = countryName
        self.latitude = latitude
        self.longitude = longitude
    }
}
