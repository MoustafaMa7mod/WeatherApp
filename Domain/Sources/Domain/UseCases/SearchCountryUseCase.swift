//
//  SearchCountryUseCase.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

public protocol SearchCountryUseCase {
    func execute(name: String) async throws -> [CountryItem]
}

public final class DefaultSearchCountryUseCase: SearchCountryUseCase {

    // MARK: - Properties
    private let repository: SearchCountryRepository

    // MARK: - Life cycle
    public init(repository: SearchCountryRepository) {
        self.repository = repository
    }

    // MARK: - Methods
    public func execute(name: String) async throws -> [CountryItem] {
        
        try await repository.searchCountry(name: name)
    }
}
