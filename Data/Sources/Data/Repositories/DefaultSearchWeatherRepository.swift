//
//  DefaultSearchWeatherRepository.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation
import Domain

public final class DefaultSearchWeatherRepository: SearchWeatherRepository {
    
    // MARK: - Properties
    private let searchWeatherRemoteAPI: SearchWeatherRemoteAPI

    // MARK: - Methods
    public init(searchWeatherRemoteAPI: SearchWeatherRemoteAPI) {
        self.searchWeatherRemoteAPI = searchWeatherRemoteAPI
    }

    public func searchWeather(citName: String) async throws -> [CountryItem] {
        let response = try await searchWeatherRemoteAPI.searchWeather(citName: citName)
      
        return response.map{ $0.toDomain() }
    }
}
