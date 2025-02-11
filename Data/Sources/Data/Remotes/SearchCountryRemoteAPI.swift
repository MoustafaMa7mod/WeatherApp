//
//  SearchCountryRemoteAPI.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import NetworkLayer

/// A protocol that defines a remote API for searching countries by name.
public protocol SearchCountryRemoteAPI {
    
    /// Searches for countries that match the given name using a remote API.
    ///
    /// - Parameter name: The name or partial name of the country to search for.
    /// - Returns: An array of `CountryDataModel` objects retrieved from the API.
    /// - Throws: An error if the network request fails or data retrieval is unsuccessful.
    func searchCountry(name: String) async throws -> [CityDataModel]
}

public final class DefaultSearchCountryRemoteAPI: SearchCountryRemoteAPI {

    private let networkService: NetworkService

    // MARK: - Life cycle
    
    /// Initializes the remote API implementation with a network service.
    ///
    /// - Parameter networkService: An instance of `NetworkService` to handle API requests.
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    /// Searches for countries that match the given name using the remote API.
    ///
    /// - Parameter name: The name or partial name of the country to search for.
    /// - Returns: An array of `CountryDataModel` objects retrieved from the API.
    /// - Throws: An error if the network request fails.
    public func searchCountry(name: String) async throws -> [CityDataModel] {

        /// - `"q=\(name)"`: Specifies the search query parameter where `name` is the user-provided country name or partial name.
        let result: [CityDataModel] = try await networkService.fetchData(
            urlString: "search.json?",
            query: "q=\(name)"
        )

        return result
    }
}
