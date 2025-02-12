//
//  MockSearchCountryRepository.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain
import NetworkLayer

class MockSearchCountryRepository: SearchCountryRepository {
    
    var error: APIError?

    public init(error: APIError? = nil) {
        self.error = error
    }

    public func searchCountry(name: String) async throws -> [CityItem] {
        
        if let error = error {
            throw error
        }
    
        return cityItems()
    }
}
