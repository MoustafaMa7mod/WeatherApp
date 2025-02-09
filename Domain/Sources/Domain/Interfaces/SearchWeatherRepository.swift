//
//  SearchCountryRepository.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

public protocol SearchCountryRepository {
    func searchCountry(name: String) async throws -> [CountryItem]
}
