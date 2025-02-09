//
//  SearchWeatherRepository.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

public protocol SearchWeatherRepository {
    func searchWeather(citName: String) async throws -> [CountryItem]
}
