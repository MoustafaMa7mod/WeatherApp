//
//  Double+extension.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

/// extension of Double to get the temperature in celiues
extension Double {
    func getTemperature() -> String {
        return String(format: "%.0f", self - 273.15)
    }
}
