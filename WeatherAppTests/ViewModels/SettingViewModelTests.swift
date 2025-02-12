//
//  SettingViewModelTests.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
@testable import WeatherApp

final class SettingViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Clear UserDefaults before each test
        UserDefaults.standard.removeObject(
            forKey: Constants.UserDefaultsKeys.celsiusKey
        )
    }

    override func tearDown() {
        // Clear UserDefaults after each test
        UserDefaults.standard.removeObject(
            forKey: Constants.UserDefaultsKeys.celsiusKey
        )
        super.tearDown()
    }
    
    func testDefaultIsCelsius_WhenNoValueStored() {
        let viewModel = SettingViewModel()
        
        XCTAssertTrue(
            viewModel.isCelsius,
            "Default value should be true when no setting is stored"
        )
    }

    func testIsCelsius_ChangesAndPersists() {
        let viewModel = SettingViewModel()
        
        viewModel.isCelsius = false
        
        XCTAssertFalse(
            UserDefaults.standard.bool(
                forKey: Constants.UserDefaultsKeys.celsiusKey
            ),
            "UserDefaults should store the updated isCelsius value"
        )
        
        let newViewModel = SettingViewModel()
        XCTAssertFalse(
            newViewModel.isCelsius,
            "New instance should load persisted value from UserDefaults"
        )
    }
}
