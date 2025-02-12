//
//  WeatherComponentViewModelDelegate.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 11/02/2025.
//

import Domain
import SwiftUI

class WeatherComponentViewModelDelegate: ObservableObject {
    
    @Published var weatherItem: WeatherItem?
    @Published var weatherItemPresentationModel: WeatherItemPresentationModel?
}
