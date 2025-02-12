//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation
import Domain
import Combine

final class SearchViewModel: ObservableObject {
    
    // MARK: - Properties
    private var searchCountryUseCase: SearchCountryUseCase
    private var getWeatherUseCase: GetWeatherUseCase
    private var favoritesCityLocalUseCase: FavoritesCityLocalUseCase
    private let locationManager = DefaultLocationManager()
    private var cancellable = Set<AnyCancellable>()
    private var isObserverActive = false
    var items: [CountryItemPresentationModel] = []
    @Published var cityName = "" {
        didSet {
            if !isObserverActive && !cityName.isEmpty {
                isObserverActive = true
                startSearch()
            }
        }
    }
    
    // MARK: - Methods
    init(
        searchCountryUseCase: SearchCountryUseCase,
        getWeatherUseCase: GetWeatherUseCase,
        favoritesCityLocalUseCase: FavoritesCityLocalUseCase
    ) {
        self.searchCountryUseCase = searchCountryUseCase
        self.getWeatherUseCase = getWeatherUseCase
        self.favoritesCityLocalUseCase = favoritesCityLocalUseCase
    }
    
    /// Creates and returns a `WeatherDetailsViewModel` for a given latitude and longitude.
    ///
    /// - Parameters:
    ///   - cityName: The cityName.
    ///   - longitude: The longitude of the location.
    /// - Returns: An instance of `WeatherDetailsViewModel` configured with the given coordinates.
    func initialViewModel(cityName: String, cityID: Int) -> WeatherDetailsViewModel {
        
        WeatherDetailsViewModel(
            getWeatherUseCase: getWeatherUseCase,
            favoritesCityLocalUseCase: favoritesCityLocalUseCase,
            cityName: cityName,
            cityID: cityID
        )
    }
    
    /// Sets up an observer to listen for changes in `cityName` and trigger searches.
    func startSearch() {
        $cityName
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] name in
                guard let self, !name.isEmpty else {
                    self?.items = []
                    return
                }
                
                self.fetchSearchCountry(name: name)
            }
            .store(in: &cancellable)
    }
}

// MARK: - Private Methods
extension SearchViewModel {
    
    /// Fetches country data based on the user's search input.
    ///
    /// - Parameter name: The name of the country or city to search for.
    private func fetchSearchCountry(name: String) {
        
        Task(priority: .background) {
            
            do {
                let items = try await self.searchCountryUseCase.execute(name: name)
                self.items = items.map { CountryItemPresentationModel(model: $0) }
                await self.reloadView()
            } catch _ {
                //                        await handleResponseError(error)
            }
        }
    }
    
    /// Triggers a UI update after the data has been modified.
    @MainActor
    private func reloadView() {
        objectWillChange.send()
    }
}

