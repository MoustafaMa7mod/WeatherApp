//
//  MockSearchCountryUseCase+MockData.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain

extension MockSearchCountryUseCase {
    
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
