//
//  WeatherFactory.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Domain
import Data

protocol WeatherFactory {
    func makeGetWeatherUseCase() -> GetWeatherUseCase
}

final class DefaultWeatherFactory: WeatherFactory {

    func makeGetWeatherUseCase() -> GetWeatherUseCase {
        DefaultGetWeatherUseCase(repository: makeWeatherRepository())
    }
    
    private func makeWeatherRepository() -> WeatherRepository {
        DefaultWeatherRepository(weatherRemoteAPI: makeWeatherRemoteAPI())
    }
    
    private func makeWeatherRemoteAPI() -> WeatherRemoteAPI {
        DefaultWeatherRemoteAPI()
    }
}
