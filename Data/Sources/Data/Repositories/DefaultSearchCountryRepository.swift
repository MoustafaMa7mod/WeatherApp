//
//  DefaultSearchCountryRepository.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation
import Domain

/// The default implementation of `SearchCountryRepository`, responsible for retrieving country search results from a remote API.
public final class DefaultSearchCountryRepository: SearchCountryRepository {
    
    // MARK: - Properties
    private let searchCountryRemoteAPI: SearchCountryRemoteAPI

    // MARK: - Methods
    
    /// Initializes the repository with a remote API instance.
    ///
    /// - Parameter searchCountryRemoteAPI: An instance of `SearchCountryRemoteAPI` used to fetch country data.
    public init(searchCountryRemoteAPI: SearchCountryRemoteAPI) {
        self.searchCountryRemoteAPI = searchCountryRemoteAPI
    }

    /// Searches for countries that match the given name.
    ///
    /// - Parameter name: The name or partial name of the country to search for.
    /// - Returns: An array of `CountryItem` objects transformed from the API response.
    /// - Throws: An error if the network request fails.
    public func searchCountry(name: String) async throws -> [CountryItem] {
        let response = try await searchCountryRemoteAPI.searchCountry(name: name)
      
        return response.map{ $0.toDomain() }
    }
}
