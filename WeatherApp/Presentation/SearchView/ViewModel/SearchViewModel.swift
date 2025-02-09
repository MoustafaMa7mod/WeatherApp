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

    private var useCase: SearchCountryUseCase
    private let locationManager = DefaultLocationManager()
    private var cancellable = Set<AnyCancellable>()
    var items: [CountryItemPresentationModel] = []
    
    @Published var cityName = ""

    init(useCase: SearchCountryUseCase) {
        self.useCase = useCase
        setupSearchObserver()
    }
    
    private func setupSearchObserver() {
        $cityName
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self, !query.isEmpty else {
                    self?.items = []
                    return
                }
               
                Task(priority: .background) {
                    
                    do {
                        let items = try await self.useCase.execute(name: query)
                        self.items = items.map { CountryItemPresentationModel(model: $0) }
                        
                        await self.reloadView()
                    } catch _ {
                        //                        await handleResponseError(error)
                    }
                }
            }
            .store(in: &cancellable)
    }
    
    @MainActor
    private func reloadView() {
        objectWillChange.send()
    }
}
