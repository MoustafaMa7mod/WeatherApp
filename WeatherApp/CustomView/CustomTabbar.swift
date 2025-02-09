//
//  CustomTabbar.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import SwiftUI

// MARK: - Tabbar Bar Customization
struct CustomTabbar {
    
    static func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
