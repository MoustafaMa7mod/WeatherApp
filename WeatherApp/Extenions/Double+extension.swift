//
//  Double+extension.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

/// An extension of `Double` to convert temperature values from Kelvin to Celsius.
extension Double {
    
    /// Converts the temperature from Kelvin to Celsius and returns it as a formatted string.
    func getTemperature() -> String {
        return String(format: "%.0f", self - 273.15)
    }
}
