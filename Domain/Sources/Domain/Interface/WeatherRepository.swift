//
//  WeatherRepository.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation

public protocol WeatherRepository {
    func fetchCurrentWeather(with url: String) async throws -> WeatherItem
}
