//
//  CustomNavigationBar.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import SwiftUI

// MARK: - Navigation Bar Customization
struct CustomNavigationBar {
    
    static func setupAppearance() {
        // Create a new appearance configuration for the navigation bar
        let appearance = UINavigationBarAppearance()

        // Set the background color of the navigation bar using a custom SwiftUI color
        // Convert `Color.darkAppBlue` (SwiftUI) to `UIColor` for compatibility with UIKit
        appearance.backgroundColor = UIColor(Color.darkAppBlue)

        // Set the title text color to white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        // Apply the appearance settings to different navigation bar states:
        // - `standardAppearance` applies when the navigation bar is in its default state.
        // - `scrollEdgeAppearance` applies when scrolling to the edge in large-title mode.
        // - `compactAppearance` applies when the navigation bar is in compact mode (e.g., smaller height).
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance

        // Customize the appearance of the search bar's "Cancel" button.
        // `UIBarButtonItem.appearance()` modifies the default style for all UIBarButtonItems
        // inside a UISearchBar, setting their tint color to white.
        UIBarButtonItem.appearance(
            whenContainedInInstancesOf: [UISearchBar.self]
        ).tintColor = UIColor.white
    }
}
