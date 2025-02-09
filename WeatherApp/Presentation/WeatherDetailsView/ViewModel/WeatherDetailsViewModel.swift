//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation
import Domain

final class WeatherDetailsViewModel: ObservableObject {

    private var useCase: GetWeatherUseCase
    var weatherItemPresentationModel: WeatherItemPresentationModel?
    var weatherComponentViewModel: WeatherComponentViewModel?
    
    @Published var locationDenied = false

    init(
        useCase: GetWeatherUseCase,
        latitude: String,
        longitude: String
    ) {
        self.useCase = useCase

        initialViewModel(latitude: latitude, longitude: longitude)
    }
}

// MARK: - Private Methods
extension WeatherDetailsViewModel {

    private func initialViewModel(
        latitude: String,
        longitude: String
    ) {
        
        weatherComponentViewModel = WeatherComponentViewModel(
            useCase: useCase,
            latitude: latitude,
            longitude: longitude
        )
    }
}
