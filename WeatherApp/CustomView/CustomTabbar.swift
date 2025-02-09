//
//  CustomTabbar.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import SwiftUI

/// A utility struct for customizing the appearance of the tab bar.
struct CustomTabbar {
    
    /// Configures and applies a custom appearance for the `UITabBar`.
    ///
    /// - Sets an opaque background.
    /// - Changes the background color to white.
    /// - Applies the customized appearance to both `standardAppearance` and `scrollEdgeAppearance`.
    static func setupAppearance() {
        let appearance = UITabBarAppearance()
        
        /// Configures the tab bar with an opaque background to ensure a solid look.
        appearance.configureWithOpaqueBackground()
        
        /// Sets the background color of the tab bar to white.
        appearance.backgroundColor = .white
        
        /// Applies the appearance settings to all tab bars in the app.
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

