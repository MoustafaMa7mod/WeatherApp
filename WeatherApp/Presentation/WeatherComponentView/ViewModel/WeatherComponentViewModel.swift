//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//
import Domain
import Foundation

final class WeatherComponentViewModel: ObservableObject {

    // MARK: - Properties
    private var useCase: GetWeatherUseCase
    private var cityName: String
    var delegate: WeatherComponentViewModelDelegate?
    var weatherItemPresentationModel: WeatherItemPresentationModel?
    
    @Published var weatherItem: WeatherItem?
    
    // MARK: - Methods
    init(
        useCase: GetWeatherUseCase,
        delegate: WeatherComponentViewModelDelegate? = nil,
        cityName: String
    ) {
        self.useCase = useCase
        self.delegate = delegate
        self.cityName = cityName
    }
    
    func onAppear() {
        Task(priority: .background) {
            
            do {
                try await fetchWeatherInfo(cityName: cityName)
                await reloadView()
            } catch let error {
                delegate?.errorDescription = error.localizedDescription
                await reloadView()
            }
        }
        
    }
}

// MARK: - Fetch data request
extension WeatherComponentViewModel {
    
    /// Fetches weather information for a given latitude and longitude.
    ///
    /// - Parameters:
    ///   - cityName: The cityName
    func fetchWeatherInfo(cityName: String) async throws {
        
        let item = try await useCase.execute(cityName: cityName)
        weatherItemPresentationModel = WeatherItemPresentationModel(
            model: item
        )
        delegate?.weatherItem = item
        delegate?.weatherItemPresentationModel = weatherItemPresentationModel
    }
}

// MARK: - Private Methods
extension WeatherComponentViewModel {
    
    /// Triggers a UI update after the data has been modified.
    @MainActor
    private func reloadView() {
        objectWillChange.send()
    }
}
