//
//  HomeViewModelTests.swift
//  WeatherAppTests
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
import CoreLocation
import Combine
@testable import WeatherApp

final class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockUseCase: MockGetWeatherUseCase!
    var mockLocationManager: MockLocationManager!
    var cancellable: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockGetWeatherUseCase()
        mockLocationManager = MockLocationManager()
        
        viewModel = HomeViewModel(useCase: mockUseCase)
        viewModel.locationManager = mockLocationManager
        viewModel.locationManager.delegate = viewModel
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        mockLocationManager = nil
        cancellable.removeAll()
        super.tearDown()
    }
    
    func testLocationUpdateTriggersWeatherFetch() {

        let mockLocation = CLLocationCoordinate2D(
            latitude: 51.5171,
            longitude: -0.1062
        )
        mockLocationManager.mockLocation = mockLocation
        
        let expectation = expectation(description: "Weather data fetched after location update")
        
        viewModel.$weatherComponentViewModel
            .dropFirst()
            .sink { model in
                if model != nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
        
        viewModel.locationManager.requestLocation()
        
        wait(for: [expectation], timeout: 2.0)
        XCTAssertNotNil(viewModel.weatherComponentViewModel)
    }

    func testLocationDenied() {
        mockLocationManager.shouldFail = true
        
        let expectation = expectation(
            description: "Location denied flag should be set"
        )
        
        viewModel
            .$locationDenied
            .dropFirst() // Skip initial value
            .sink { denied in
                if denied {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
        
        viewModel.locationManager.requestLocation()
        
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(viewModel.locationDenied)
    }
    
    func testWeatherComponentViewModelCreatedAfterLocationUpdate() {

        let mockLocation = CLLocationCoordinate2D(
            latitude: 51.5171,
            longitude: -0.1062
        )
        mockLocationManager.mockLocation = mockLocation
        
        let expectation = expectation(
            description: "WeatherComponentViewModel should be created after location update"
        )

        viewModel
            .$weatherComponentViewModel
            .dropFirst()
            .sink { model in
                if model != nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)

        viewModel.locationManager.requestLocation()
        
        wait(for: [expectation], timeout: 2.0)
        XCTAssertNotNil(viewModel.weatherComponentViewModel)
    }
    
}
