//
//  SearchCountryRepository.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

/// A protocol that defines a repository for searching countries by name.
public protocol SearchCountryRepository {
    
    /// Searches for countries that match the given name.
    ///
    /// - Parameter name: The name or partial name of the country to search for.
    /// - Returns: An array of `CountryItem` objects that match the search query.
    /// - Throws: An error if the search request fails.
    func searchCountry(name: String) async throws -> [CountryItem]
}
