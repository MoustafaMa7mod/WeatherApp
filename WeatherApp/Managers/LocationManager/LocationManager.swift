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
    
    /// Notifies when the authorization status for location services changes.
    /// - Parameter status: The new authorization status, which can be one of the following:
    ///   - `.notDetermined`: The user has not yet made a choice regarding location permissions.
    ///   - `.authorizedWhenInUse`: The app is authorized to access location data while in use.
    ///   - `.authorizedAlways`: The app is authorized to access location data at all times.
    ///   - `.denied`: The user has explicitly denied location access.
    ///   - `.restricted`: The app is restricted from using location services, possibly due to parental controls or enterprise settings.
    func didChangeAuthorization(status: CLAuthorizationStatus)

}
