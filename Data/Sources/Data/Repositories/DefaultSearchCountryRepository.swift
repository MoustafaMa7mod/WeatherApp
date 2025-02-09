//
//  DefaultSearchCountryRepository.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation
import Domain

public final class DefaultSearchCountryRepository: SearchCountryRepository {
    
    // MARK: - Properties
    private let searchCountryRemoteAPI: SearchCountryRemoteAPI

    // MARK: - Methods
    public init(searchCountryRemoteAPI: SearchCountryRemoteAPI) {
        self.searchCountryRemoteAPI = searchCountryRemoteAPI
    }

    public func searchCountry(name: String) async throws -> [CountryItem] {
        let response = try await searchCountryRemoteAPI.searchCountry(name: name)
      
        return response.map{ $0.toDomain() }
    }
}
