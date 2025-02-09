//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation
import Domain

final class SearchViewModel: ObservableObject {

    private var useCase: GetWeatherUseCase
    private let locationManager = DefaultLocationManager()
    var weatherItemPresentationModel: WeatherItemPresentationModel?
    
    @Published var locationDenied = false

    init(useCase: GetWeatherUseCase) {
        self.useCase = useCase

    }
}
