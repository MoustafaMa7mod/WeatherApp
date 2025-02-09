//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation
import CoreLocation

/// A protocol that defines the contract for receiving location updates.
protocol LocationManager: AnyObject {
    /// Called when the location is successfully updated.
    /// - Parameter coordinate: The updated location coordinates.
    func didUpdateLocation(_ coordinate: CLLocationCoordinate2D)
    
    /// Called when there is an error retrieving the location.
    /// - Parameter error: The error encountered while fetching the location.
    func didFailWithError(_ error: Error)
}
