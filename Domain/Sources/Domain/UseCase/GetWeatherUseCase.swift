//
//  GetWeatherUseCase.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

public protocol GetWeatherUseCase {
    func execute() async throws -> WeatherItem
}

public final class DefaultGetWeatherUseCase: GetWeatherUseCase {

    // MARK: - Properties
    private let repository: WeatherRepository

    // MARK: - Life cycle
    public init(repository: WeatherRepository) {
        self.repository = repository
    }

    // MARK: - Methods
    public func execute() async throws -> WeatherItem {
        return try await repository.fetchCurrentWeather(with: "")
    }
}
