//
//  Double+extension.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation

/// An extension of `Double` to convert temperature values from Kelvin to Celsius.
extension Double {
    
    /// Converts the temperature from Kelvin to the user's preferred unit (Celsius or Fahrenheit)
    /// and returns it as a formatted string.
    func getTemperature() -> String {
        
        let isCelsius = UserDefaults.standard.object(
            forKey: Constants.UserDefaultsKeys.celsiusKey
        ) as? Bool ?? true
        
        let temp = isCelsius ? (self - 273.15) : ((self - 273.15) * 9/5 + 32)
        
        return String(format: "%.1f°%@", temp, isCelsius ? "C" : "F")
    }
}
