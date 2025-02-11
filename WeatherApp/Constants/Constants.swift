//
//  Constants.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation

/// A struct that defines constant values used throughout the application.
public struct Constants {

    /// A nested struct containing keys for retrieving values from the Info.plist file.
    public struct PlistKeys {
        /// The key used to retrieve the base URL from the Info.plist file.
        static let baseURL = "baseURL"
        
        /// The key used to retrieve the API key from the Info.plist file.
        static let apiKey = "apiKey"        
    }
    
    /// A nested struct containing keys for storing and retrieving values from `UserDefaults`.
    public struct UserDefaultsKeys {
        /// The key used to store and retrieve the user's preferred temperature unit.
        static let celsiusKey = "celsiusKey"
    }
}
