//
//  CountryItemPresentationModel.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Domain
import Foundation

struct CountryItemPresentationModel: Identifiable, Hashable {
 
    let id: Int
    let cityName: String
    let latitude: Double
    let longitude: Double

    public init(model: CityItem) {
        self.id = model.id
        self.cityName = model.cityName
        self.latitude = model.latitude
        self.longitude = model.longitude
    }
}

 // MARK: - Conform Equatable
extension CountryItemPresentationModel: Equatable {

    static func == (
        lhs: CountryItemPresentationModel,
        rhs: CountryItemPresentationModel
    ) -> Bool {
        
        return lhs.id == rhs.id
    }
}
