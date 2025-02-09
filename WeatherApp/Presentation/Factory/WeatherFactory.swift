//
//  WeatherFactory.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Domain
import Data
import NetworkLayer

protocol WeatherFactory {
    func makeGetWeatherUseCase() -> GetWeatherUseCase
    func makeSearchWeatherUseCase() -> SearchWeatherUseCase
}

final class DefaultWeatherFactory: WeatherFactory {

    func makeGetWeatherUseCase() -> GetWeatherUseCase {
        DefaultGetWeatherUseCase(repository: makeWeatherRepository())
    }
    
    func makeSearchWeatherUseCase() -> SearchWeatherUseCase {
        DefaultSearchWeatherUseCase(repository: makeSearchWeatherRepository())
    }
}

// MARK: - make get weather view
extension DefaultWeatherFactory {
    
    private func makeWeatherRepository() -> WeatherRepository {
        DefaultWeatherRepository(weatherRemoteAPI: makeWeatherRemoteAPI())
    }
    
    private func makeWeatherRemoteAPI() -> WeatherRemoteAPI {
        DefaultWeatherRemoteAPI(
            networkService: makeWeatherNetworkService()
        )
    }
    
    private func makeWeatherNetworkService() -> NetworkService {
        NetworkService(
            baseURL: ConfigurationManager.shared.baseUrl,
            apiKey: ConfigurationManager.shared.apiKey
        )
    }
}

// MARK: - make search weather view
extension DefaultWeatherFactory {
    
    private func makeSearchWeatherRepository() -> SearchWeatherRepository {
        DefaultSearchWeatherRepository(
            searchWeatherRemoteAPI: makeSearchWeatherRemoteAPI()
        )
    }
    
    private func makeSearchWeatherRemoteAPI() -> SearchWeatherRemoteAPI {
        DefaultSearchWeatherRemoteAPI(
            networkService: makeSearchWeatherNetworkService()
        )
    }
    
    private func makeSearchWeatherNetworkService() -> NetworkService {
        NetworkService(
            baseURL: ConfigurationManager.shared.searchUrl,
            apiKey: ConfigurationManager.shared.apiKey
        )
    }
}
