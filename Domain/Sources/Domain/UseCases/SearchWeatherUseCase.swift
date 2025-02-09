//
//  SearchWeatherUseCase.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

public protocol SearchWeatherUseCase {
    func execute(cityName: String) async throws -> [CountryItem]
}

public final class DefaultSearchWeatherUseCase: SearchWeatherUseCase {

    // MARK: - Properties
    private let repository: SearchWeatherRepository

    // MARK: - Life cycle
    public init(repository: SearchWeatherRepository) {
        self.repository = repository
    }

    // MARK: - Methods
    public func execute(cityName: String) async throws -> [CountryItem] {
        
        try await repository.searchWeather(citName: cityName)
    }
}
