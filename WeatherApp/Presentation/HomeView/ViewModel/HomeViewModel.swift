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
    
    /// A published property to track whether location access is denied.
    @Published var locationDenied = false

    init(useCase: GetWeatherUseCase) {
        self.useCase = useCase
        locationManager.delegate = self

        initialViewModel()
    }
}

// MARK: - Private Methods
extension HomeViewModel {

    /// Initializes the view model by checking the user's location and setting up the weather component.
    private func initialViewModel() {
        
        guard let location = locationManager.userLocation else {
            locationManager.requestLocation()
            return
        }

        /// Creates a `WeatherComponentViewModel` instance with the user's location.
        weatherComponentViewModel = WeatherComponentViewModel(
            useCase: useCase,
            latitude: location.latitude.description,
            longitude: location.longitude.description
        )
    }
}

// MARK: - Location Manager
extension HomeViewModel: LocationManager {
    
    /// Called when the user's location is successfully updated.
    ///
    /// - Parameter coordinate: The updated coordinates of the user's location.
    func didUpdateLocation(_ coordinate: CLLocationCoordinate2D) {

        if let weatherComponentViewModel {
            
            weatherComponentViewModel.fetchWeatherInfo(
                latitude: coordinate.latitude.description,
                longitude: coordinate.longitude.description)
            
        }
    }

    /// Called when the location manager encounters an error.
    ///
    /// - Parameter error: The error that occurred.
    func didFailWithError(_ error: Error) {
        locationDenied = true
    }
}
