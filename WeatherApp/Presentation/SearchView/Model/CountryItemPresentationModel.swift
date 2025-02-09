//
//  CountryItemPresentationModel.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Domain
import Foundation

struct CountryItemPresentationModel: Identifiable {
 
    let id: UUID
    let countryName: String
    let latitude: Double
    let longitude: Double

    public init(model: CountryItem) {
        self.id = UUID()
        self.countryName = model.countryName
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
