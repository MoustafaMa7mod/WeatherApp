//
//  CurrentWeather.swift
//  Data
//
//  Created by Mostafa Mahmoud on 11/02/2025.
//

public struct CurrentWeatherDataModel: Codable {
    
    let tempCelsius: Double?
    let tempFahrenheit: Double?
    let humidity: Int?
    let windSpeed: Double?
    let condition: WeatherConditionDataModel?
    
    public init(
        tempCelsius: Double? = nil,
        tempFahrenheit: Double? = nil,
        humidity: Int? = nil,
        windSpeed: Double? = nil,
        condition: WeatherConditionDataModel? = nil
    ) {
        self.tempCelsius = tempCelsius
        self.tempFahrenheit = tempFahrenheit
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.condition = condition
    }
    
    enum CodingKeys: String, CodingKey {
        case tempCelsius = "temp_c"
        case tempFahrenheit = "temp_f"
        case windSpeed = "wind_kph"
        case humidity, condition
    }
}
