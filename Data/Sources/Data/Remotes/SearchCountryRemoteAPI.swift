//
//  SearchCountryRemoteAPI.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import NetworkLayer

public protocol SearchCountryRemoteAPI {
    func searchCountry(name: String) async throws -> [CountryDataModel]
}

public final class DefaultSearchCountryRemoteAPI: SearchCountryRemoteAPI {

    private let networkService: NetworkService

    // MARK: - Life cycle
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    public func searchCountry(name: String) async throws -> [CountryDataModel] {
        let result: [CountryDataModel] = try await networkService.fetchData(
            from: "q=\(name)&limit=10"
        )

        return result
    }
}
