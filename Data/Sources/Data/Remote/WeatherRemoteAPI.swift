//
//  GetWeatherRemoteAPI.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import NetworkLayer

public protocol WeatherRemoteAPI {
    func fetchCurrentWeather(latitude: String, longitude: String) async throws -> WeatherDataModel
}

public final class DefaultWeatherRemoteAPI: WeatherRemoteAPI {

    private let networkService: NetworkService

    // MARK: - Life cycle
    public init(baseURL: String, apiKey: String) {
        self.networkService = NetworkService(baseURL: baseURL, apiKey: apiKey)
    }
    
    public func fetchCurrentWeather(
        latitude: String,
        longitude: String
    ) async throws -> WeatherDataModel {
        let result: WeatherDataModel = try await networkService.fetchData(
            from: "lat=\(latitude)&lon=\(longitude)"
        )

        return result
    }
}
