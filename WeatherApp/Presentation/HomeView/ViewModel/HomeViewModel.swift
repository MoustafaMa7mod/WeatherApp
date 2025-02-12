//
// HomeViewModel.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation
import Domain
import CoreLocation
import Combine

final class HomeViewModel: ObservableObject {

    private var useCase: GetWeatherUseCase
    private var cancellable = Set<AnyCancellable>()

    var locationManager: LocationManaging
    @Published var weatherItemPresentationModel: WeatherItemPresentationModel?
    @Published var weatherComponentViewModel: WeatherComponentViewModel?
    /// A published property to track whether location access is denied.
    @Published var locationDenied = false

    init(
        useCase: GetWeatherUseCase,
        locationManager: LocationManaging = DefaultLocationManager()
    ) {
        self.useCase = useCase
        self.locationManager = locationManager
        self.locationManager.delegate = self

        loadData()
    }
}

// MARK: - Private Methods
extension HomeViewModel {

    /// Initializes the view model by checking the user's location and setting up the weather component.
    private func loadData() {
        
        guard let location = locationManager.userLocation else {
            locationManager.requestLocation()
            return
        }
        
        getCityAndCountryLocation(
            latitude: location.latitude,
            longitude: location.longitude
        )
    }
    
    /// Observes changes to the `weatherItem` property in `weatherComponentViewModel`
    /// and triggers a check to see if the city is in the favorites list.
    ///
    /// This function sets up a Combine subscription to listen for updates to
    /// `weatherItem` via its `@Published` property. When `weatherItem` is updated,
    /// it extracts the non-nil value and calls `checkCityInFavorites(id:)` to verify
    /// if the city is in the favorites.
    ///
    /// - Important: This method ensures that only non-nil values of `weatherItem`
    ///   are processed, preventing unnecessary operations.
    /// - Note: Uses `[weak self]` to prevent retain cycles.
    ///
    /// Example Usage:
    /// ```
    /// observeWeatherItemChanges()
    /// ```
    private func observeWeatherItemChanges() {
        
        weatherComponentViewModel?
            .delegate?
            .$weatherItemPresentationModel
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                guard let self else { return }
                self.weatherItemPresentationModel = items
            }
            .store(in: &cancellable)
    }
}

// MARK: - Location Manager
extension HomeViewModel: LocationManager {
    
    /// Called when the user's location is successfully updated.
    ///
    /// - Parameter coordinate: The updated coordinates of the user's location.
    func didUpdateLocation(_ coordinate: CLLocationCoordinate2D) {

        getCityAndCountryLocation(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
    }
    
    func getCityAndCountryLocation(latitude: Double, longitude: Double) {
        
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { [weak self] location, _ in
            guard let self,
                  let location = location?.first else { return }
            /// Creates a `WeatherComponentViewModel` instance with the user's location.
            weatherComponentViewModel = WeatherComponentViewModel(
                useCase: self.useCase,
                delegate: WeatherComponentViewModelDelegate(),
                cityName: location.locality ?? ""
            )
            
            observeWeatherItemChanges()
        }
    }

    /// Called when the location manager encounters an error.
    ///
    /// - Parameter error: The error that occurred.
    func didFailWithError(_ error: Error) {
        locationDenied = true
    }
}
