//
//  WeatherComponentViewModelTests.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
@testable import WeatherApp

final class WeatherComponentViewModelTests: XCTestCase {

    var viewModel: WeatherComponentViewModel!
    var mockUseCase: MockGetWeatherUseCase!

    override func setUp() {
        super.setUp()
        mockUseCase = MockGetWeatherUseCase()
        viewModel = WeatherComponentViewModel(useCase: mockUseCase, cityName: "Giza")
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }

    func testFetchWeatherInfo_Success() async {
        let expectation = expectation(description: "Fetching weather succeeds")

        Task {
            viewModel.onAppear()
            try? await Task.sleep(nanoseconds: 1000_000_000) // 🔹 Wait 0.5s to allow updates
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 3.0)

        XCTAssertNotNil(viewModel.weatherItemPresentationModel)
        XCTAssertEqual(viewModel.weatherItemPresentationModel?.cityName, "Giza")
        XCTAssertEqual(viewModel.weatherItemPresentationModel?.weatherHumidity, "77%")
    }

    func testFetchWeatherInfo_Failure() async {
        mockUseCase.mockError = .requestFailed

        let expectation = expectation(description: "Fetching weather fails")

        Task {
            viewModel.onAppear()
            try? await Task.sleep(nanoseconds: 1000_000_000) // 🔹 Wait 0.5s to allow updates
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 3.0)

        XCTAssertNil(viewModel.weatherItemPresentationModel)
    }
}
