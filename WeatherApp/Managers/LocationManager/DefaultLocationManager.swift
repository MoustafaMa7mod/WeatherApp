//
//  DefaultLocationManager.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 10/02/2025.
//

import Foundation
import CoreLocation

protocol LocationManaging {
    var userLocation: CLLocationCoordinate2D? { get }
    var delegate: LocationManager? { get set }
    func requestLocation()
}

/// A class responsible for managing location updates using `CLLocationManager`.
/// This class requests location permissions and provides updates via a delegate.
class DefaultLocationManager: NSObject, LocationManaging, CLLocationManagerDelegate {
    
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
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways, .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        case .denied, .restricted:
            delegate?.didChangeAuthorization(status: status)
        @unknown default:
            break
        }
    }
    
    /// Called when new location data is available.
    /// - Parameters:
    ///   - manager: The location manager providing the update.
    ///   - locations: An array of `CLLocation` objects, with the most recent location last.
    ///
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            delegate?.didUpdateLocation(location.coordinate)
        }
    }
    
    /// Notifies when the authorization status for location services changes.
    /// - Parameter status: The new authorization status, which can be one of the following:
    ///   - `.notDetermined`: The user has not yet made a choice regarding location permissions.
    ///   - `.authorizedWhenInUse`: The app is authorized to access location data while in use.
    ///   - `.authorizedAlways`: The app is authorized to access location data at all times.
    ///   - `.denied`: The user has explicitly denied location access.
    ///   - `.restricted`: The app is restricted from using location services, possibly due to parental controls or enterprise settings.
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        delegate?.didChangeAuthorization(status: status)
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
    
    /// Called when an error occurs while retrieving location data.
    /// - Parameters:
    ///   - manager: The location manager that encountered the error.
    ///   - error: The error describing what went wrong.
    ///
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        delegate?.didFailWithError(error)
    }
}
