//
//  MockFavoritesCityLocalRepository.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain
import Domain

class MockFavoritesCityLocalRepository: FavoritesCityLocalRepository {
    
    var mockSaveSuccess: Bool = true
    var mockDeleteSuccess: Bool = true
    
    func fetchFavoritesCities() async -> [WeatherItem] {
        return weatherItemsModel()
    }
    
    func save(item: WeatherItem, cityName: String, cityID: Int) async -> Bool {
        return mockSaveSuccess
    }
    
    func deleteItem(id: Int) async -> Bool {
        return mockDeleteSuccess
    }
}
