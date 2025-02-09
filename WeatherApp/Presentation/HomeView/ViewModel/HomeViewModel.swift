//
// HomeViewModel.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation
import Domain
import CoreLocation

final class HomeViewModel: ObservableObject {

    private var useCase: GetWeatherUseCase
    private let locationManager = DefaultLocationManager()
    var weatherItemPresentationModel: WeatherItemPresentationModel?
    var weatherComponentViewModel: WeatherComponentViewModel?
    
    @Published var locationDenied = false

    init(useCase: GetWeatherUseCase) {
        self.useCase = useCase
        locationManager.delegate = self

        initialViewModel()
    }
}

// MARK: - Private Methods
extension HomeViewModel {

    private func initialViewModel() {
        
        guard let location = locationManager.userLocation else {
            locationManager.requestLocation()
            return
        }

        weatherComponentViewModel = WeatherComponentViewModel(
            useCase: useCase,
            latitude: location.latitude.description,
            longitude: location.longitude.description
        )
    }
}

// MARK: - Location Manager
extension HomeViewModel: LocationManager {
    
    func didUpdateLocation(_ coordinate: CLLocationCoordinate2D) {

        if let weatherComponentViewModel {
            
            weatherComponentViewModel.fetchWeatherInfo(
                latitude: coordinate.latitude.description,
                longitude: coordinate.longitude.description)
            
        }
    }

    func didFailWithError(_ error: Error) {
        locationDenied = true
    }
}
