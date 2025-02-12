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
    
    var dayTitle: String {
        guard let day = date.getDayOfWeek else { return "" }
        
        return day
    }
    
    var weatherIcon: URL? {
        URL(string: "https:\(icon)")
    }
    
    var minTemperatureDegree: String {
        let isCelsius = UserDefaults.standard.object(
            forKey: Constants.UserDefaultsKeys.celsiusKey
        ) as? Bool ?? true
        
        let temp = isCelsius ? minTemperatureCelsiusDegree : minTemperatureFahrenheitDegree
        
        return String(format: "%.1f°%@", temp, isCelsius ? "C" : "F")
    }
    
    var maxTemperatureDegree: String {
        let isCelsius = UserDefaults.standard.object(
            forKey: Constants.UserDefaultsKeys.celsiusKey
        ) as? Bool ?? true
        
        let temp = isCelsius ? maxTemperatureCelsiusDegree : maxTemperatureFahrenheitDegree
        
        return String(format: "%.1f°%@", temp, isCelsius ? "C" : "F")
    }

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
