//
//  DefaultLocationManager.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 10/02/2025.
//

import Foundation
import CoreLocation

/// A class responsible for managing location updates using `CLLocationManager`.
/// This class requests location permissions and provides updates via a delegate.
class DefaultLocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    weak var delegate: LocationManager?
    
    /// Returns the user's last known location, if available.
    var userLocation: CLLocationCoordinate2D? {
        locationManager.location?.coordinate
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    /// Requests the user's permission to access their location and attempts to fetch it.
    ///
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    /// Called when new location data is available.
    /// - Parameters:
    ///   - manager: The location manager providing the update.
    ///   - locations: An array of `CLLocation` objects, with the most recent location last.
    ///
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            delegate?.didUpdateLocation(location.coordinate)
        }
    }
    
    /// Called when an error occurs while retrieving location data.
    /// - Parameters:
    ///   - manager: The location manager that encountered the error.
    ///   - error: The error describing what went wrong.
    ///
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFailWithError(error)
    }
}
