//
//  MockSearchCountryRepository+MockData.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain

extension MockSearchCountryRepository {
    
    func cityItems() -> [CityItem] {
        [
            CityItem(
                id: 2801268,
                cityName: "London"
            ),
            CityItem(
                id: 279381,
                cityName: "Londrina"
            )
        ]
    }
}
