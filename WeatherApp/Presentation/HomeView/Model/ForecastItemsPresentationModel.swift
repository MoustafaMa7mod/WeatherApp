//
//  ForecastItems.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain
import SwiftUI

struct ForecastItemsPresentationModel: Identifiable {
 
    let id: UUID
    
    private let date: String
    private let maxTemperatureCelsiusDegree: Double
    private let maxTemperatureFahrenheitDegree: Double
    private let minTemperatureCelsiusDegree: Double
    private let minTemperatureFahrenheitDegree: Double
    private let icon: String

    init(model: WeatherForecastItem) {
        
        self.id = UUID()
        self.date = model.date
        self.maxTemperatureCelsiusDegree = model.maxTemperatureCelsiusDegree
        self.maxTemperatureFahrenheitDegree = model.maxTemperatureFahrenheitDegree
        self.minTemperatureCelsiusDegree = model.minTemperatureCelsiusDegree
        self.minTemperatureFahrenheitDegree = model.minTemperatureFahrenheitDegree
        self.icon = model.icon
    }
}

 // MARK: - Conform Equatable
extension ForecastItemsPresentationModel: Equatable {

    static func == (
        lhs: ForecastItemsPresentationModel,
        rhs: ForecastItemsPresentationModel
    ) -> Bool {
        
        return lhs.id == rhs.id
    }
}
