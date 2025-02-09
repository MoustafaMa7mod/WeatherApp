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
    public init() {
        self.networkService = NetworkService()
    }
    
    public func fetchCurrentWeather(
        latitude: String,
        longitude: String
    ) async throws -> WeatherDataModel {
        let result: WeatherDataModel = try await networkService.fetchData(
            from: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=daac32177cf1c717c43357a045f1654c"
        )

        return result
    }
}
