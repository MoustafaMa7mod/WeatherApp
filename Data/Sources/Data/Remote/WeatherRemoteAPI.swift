//
//  GetWeatherRemoteAPI.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import NetworkLayer

public protocol WeatherRemoteAPI {
    func fetchCurrentWeather() async throws -> WeatherDataModel
}

public final class DefaultWeatherRemoteAPI: WeatherRemoteAPI {

    private let networkService: NetworkService

    // MARK: - Life cycle
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    public func fetchCurrentWeather() async throws -> WeatherDataModel {
        let result: WeatherDataModel = try await networkService.fetchData(from: "https://api.example.com/data")

        return result
    }
}
