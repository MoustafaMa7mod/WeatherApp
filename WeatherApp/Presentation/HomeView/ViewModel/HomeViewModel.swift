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
    
    @Published var locationDenied = false

    init(useCase: GetWeatherUseCase) {
        self.useCase = useCase
        locationManager.delegate = self

        fetchWeatherInfo()
    }
}

// MARK: - Private Methods
extension HomeViewModel {
    
    private func fetchWeatherInfo() {
        
        guard let location = locationManager.userLocation else {
            locationManager.requestLocation()
            return
        }
        
        Task(priority: .background) {
            
            do {
                let items = try await useCase.execute(
                    latitude: location.latitude.description,
                    longitude: location.longitude.description
                )
                
                print("DEBUG: items \(items)")
                
            } catch _ {
                //                        await handleResponseError(error)
            }
        }
    }
}

// MARK: - Location Manager
extension HomeViewModel: LocationManager {
    
    func didUpdateLocation(_ coordinate: CLLocationCoordinate2D) {
        
        fetchWeatherInfo()
    }

    func didFailWithError(_ error: Error) {
        locationDenied = true
    }
}
