//
//  SearchWeatherRemoteAPI.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import NetworkLayer

public protocol SearchWeatherRemoteAPI {
    func searchWeather(citName: String) async throws -> [CountryDataModel]
}

public final class DefaultSearchWeatherRemoteAPI: SearchWeatherRemoteAPI {

    private let networkService: NetworkService

    // MARK: - Life cycle
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    public func searchWeather(citName: String) async throws -> [CountryDataModel] {
        let result: [CountryDataModel] = try await networkService.fetchData(
            from: "q=\(citName)&limit=10"
        )

        return result
    }
}
