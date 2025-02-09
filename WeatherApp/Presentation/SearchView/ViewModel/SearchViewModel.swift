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

    private var searchCountryUseCase: SearchCountryUseCase
    private var getWeatherUseCase: GetWeatherUseCase
    private let locationManager = DefaultLocationManager()
    private var cancellable = Set<AnyCancellable>()
    var items: [CountryItemPresentationModel] = []
    
    @Published var cityName = ""

    init(searchCountryUseCase: SearchCountryUseCase, getWeatherUseCase: GetWeatherUseCase) {
        self.searchCountryUseCase = searchCountryUseCase
        self.getWeatherUseCase = getWeatherUseCase
        
        setupSearchObserver()
    }
    
   func initialViewModel(latitude: String, longitude: String) -> WeatherDetailsViewModel{
        WeatherDetailsViewModel(
            useCase: getWeatherUseCase,
            latitude: latitude,
            longitude: longitude
        )
    }
}

// MARK: - Private Methods
extension SearchViewModel {

    private func setupSearchObserver() {
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
    
    @MainActor
    private func reloadView() {
        objectWillChange.send()
    }
}

