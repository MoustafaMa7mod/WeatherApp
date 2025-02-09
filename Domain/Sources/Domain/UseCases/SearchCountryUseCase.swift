//
//  SearchCountryUseCase.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

/// A protocol that defines a use case for searching countries by name.
public protocol SearchCountryUseCase {
    
    /// Executes the use case to search for countries based on a given name.
    ///
    /// - Parameter name: The name or partial name of the country to search for.
    /// - Returns: An array of `CountryItem` objects that match the search query.
    /// - Throws: An error if the search request fails or data retrieval is unsuccessful.
    func execute(name: String) async throws -> [CountryItem]
}

/// The default implementation of `SearchCountryUseCase`, which retrieves country data from a repository.
public final class DefaultSearchCountryUseCase: SearchCountryUseCase {

    // MARK: - Properties
    private let repository: SearchCountryRepository

    // MARK: - Life cycle
    
    /// Initializes the use case with a country search repository.
    ///
    /// - Parameter repository: An instance of `SearchCountryRepository` to handle data retrieval.
    public init(repository: SearchCountryRepository) {
        self.repository = repository
    }

    // MARK: - Methods
    
    /// Executes the use case to search for countries based on a given name.
    ///
    /// - Parameter name: The name or partial name of the country to search for.
    /// - Returns: An array of `CountryItem` objects that match the search query.
    /// - Throws: An error if the search request fails.
    public func execute(name: String) async throws -> [CountryItem] {
        
        try await repository.searchCountry(name: name)
    }
}
