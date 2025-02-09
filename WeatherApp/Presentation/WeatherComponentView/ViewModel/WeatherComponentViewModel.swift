//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//
import Domain
import Foundation

final class WeatherComponentViewModel: ObservableObject {

    private var useCase: GetWeatherUseCase

    var weatherItemPresentationModel: WeatherItemPresentationModel?
    
    init(
        useCase: GetWeatherUseCase,
        latitude: String,
        longitude: String
    ) {
        self.useCase = useCase
        
        fetchWeatherInfo(latitude: latitude, longitude: longitude)
    }
}

// MARK: - Fetch data request
extension WeatherComponentViewModel {

    func fetchWeatherInfo(latitude: String, longitude: String) {
        
        Task(priority: .background) {
            
            do {
                let item = try await useCase.execute(
                    latitude: latitude,
                    longitude: longitude
                )
                
                weatherItemPresentationModel = WeatherItemPresentationModel(model: item)
                await reloadView()
            } catch _ {
                //                        await handleResponseError(error)
            }
        }
    }
}

// MARK: - Private Methods
extension WeatherComponentViewModel {
    
    @MainActor
    private func reloadView() {
        objectWillChange.send()
    }
}
