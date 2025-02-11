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

    public init(
        id: Int,
        cityName: String
    ) {
        self.id = id
        self.cityName = cityName
    }
}
