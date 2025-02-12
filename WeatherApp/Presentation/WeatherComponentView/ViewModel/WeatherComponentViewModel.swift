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
        fetchWeatherInfo(cityName: cityName)
    }
}

// MARK: - Fetch data request
extension WeatherComponentViewModel {
    
    /// Fetches weather information for a given latitude and longitude.
    ///
    /// - Parameters:
    ///   - cityName: The cityName
    func fetchWeatherInfo(cityName: String) {
        
        Task(priority: .background) {
            
            do {
                let item = try await useCase.execute(cityName: cityName)
                weatherItemPresentationModel = WeatherItemPresentationModel(
                    model: item
                )
                delegate?.weatherItem = item
                delegate?.weatherItemPresentationModel = weatherItemPresentationModel
                
                await reloadView()
            } catch _ {
                //                        await handleResponseError(error)
            }
        }
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
