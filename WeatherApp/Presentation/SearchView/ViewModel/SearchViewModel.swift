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

    private var useCase: SearchWeatherUseCase
    private let locationManager = DefaultLocationManager()
    private var cancellable = Set<AnyCancellable>()
    var weatherItemsPresentationModel: [WeatherItemPresentationModel] = []
    
    @Published var cityName = ""

    init(useCase: SearchWeatherUseCase) {
        self.useCase = useCase
        setupSearchObserver()
    }
    
    private func setupSearchObserver() {
        $cityName
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self, !query.isEmpty else {
                    self?.weatherItemsPresentationModel = []
                    return
                }
               
                Task(priority: .background) {
                    
                    do {
                        let item = try await self.useCase.execute(
                            cityName: query
                        )
                        
                        print("DEBUG: items \(item)")
                        
//                        await reloadView()
                    } catch _ {
                        //                        await handleResponseError(error)
                    }
                }
            }
            .store(in: &cancellable)
    }
    
    
}
