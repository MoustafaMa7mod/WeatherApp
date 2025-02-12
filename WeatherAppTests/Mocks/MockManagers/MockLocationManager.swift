//
//  MockLocationManager.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import CoreLocation
@testable import WeatherApp

final class MockLocationManager: LocationManaging {
    
    var mockLocation: CLLocationCoordinate2D?
    var shouldFail = false
    weak var delegate: LocationManager?

    func requestLocation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Simulate async behavior
            if self.shouldFail {
                self.delegate?.didFailWithError(
                    NSError(domain: "LocationError", code: 1, userInfo: nil)
                )
            } else if let location = self.mockLocation {
                self.delegate?.didUpdateLocation(location)
            }
        }
    }

    var userLocation: CLLocationCoordinate2D? {
        return mockLocation
    }
}
