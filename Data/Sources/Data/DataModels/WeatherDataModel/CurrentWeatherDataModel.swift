//
//  CurrentWeather.swift
//  Data
//
//  Created by Mostafa Mahmoud on 11/02/2025.
//

struct CurrentWeatherDataModel: Codable {
    
    let tempCelsius: Double?
    let tempFahrenheit: Double?
    let humidity: Int?
    let windSpeed: Double?
    let condition: WeatherConditionDataModel?
    
    enum CodingKeys: String, CodingKey {
        case tempCelsius = "temp_c"
        case tempFahrenheit = "temp_f"
        case windSpeed = "wind_kph"
        case humidity, condition
    }
}
