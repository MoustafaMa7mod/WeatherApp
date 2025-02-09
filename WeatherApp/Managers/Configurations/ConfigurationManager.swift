//
//  ConfigurationManager.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation

/// A singleton class responsible for managing application configuration values.
/// This class retrieves values such as the API base URL and API key from the app's Info.plist file.
class ConfigurationManager {

    /// The shared singleton instance of `ConfigurationManager`.
    static let shared = ConfigurationManager()

    /// Private initializer to prevent external instantiation.
    /// Ensures that only a single instance of `ConfigurationManager` exists.
    private init() { }

    /// Retrieves the base URL for network requests from the Info.plist file.
    /// - Returns: A `String` containing the base URL.
    var baseUrl: String {
        Bundle.main.getValueFromInfoPlist(forKey: Constants.PlistKeys.baseURL)!
    }
    
    /// Retrieves the API key required for authentication from the Info.plist file.
    /// - Returns: A `String` containing the API key.
    var apiKey: String {
        Bundle.main.getValueFromInfoPlist(forKey: Constants.PlistKeys.apiKey)!
    }
    
    /// Retrieves the image URL from the Info.plist file.
    /// - Returns: A `String` containing the image URL.
    var imageUrl: String {
        Bundle.main.getValueFromInfoPlist(forKey: Constants.PlistKeys.imageURL)!
    }
}
