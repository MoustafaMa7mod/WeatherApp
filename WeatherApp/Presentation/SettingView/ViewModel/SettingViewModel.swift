//
//  SettingViewModel.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 11/02/2025.
//

import Foundation
import Domain

final class SettingViewModel: ObservableObject {
    
    @Published var isCelsius: Bool {
        didSet {
            UserDefaults.standard.set(
                isCelsius,
                forKey: Constants.UserDefaultsKeys.celsiusKey
            )
        }
    }
    
    init() {
        
        self.isCelsius = UserDefaults.standard.object(
            forKey: Constants.UserDefaultsKeys.celsiusKey
        ) as? Bool ?? true
    }
}
