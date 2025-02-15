//
//  WeatherComponentViewModelTests.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
import NetworkLayer

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
        
        do {
            try await viewModel.fetchWeatherInfo(cityName: "Giza")
            XCTAssertNotNil(viewModel.weatherItemPresentationModel)
            XCTAssertEqual(viewModel.weatherItemPresentationModel?.cityName, "Giza")
            XCTAssertEqual(viewModel.weatherItemPresentationModel?.weatherHumidity, "77%")

        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testFetchWeatherInfo_Failure() async {
        mockUseCase.mockError = .requestFailed

        do {
            try await viewModel.fetchWeatherInfo(cityName: "Giza")

            XCTFail("Expected an error but got success")
        } catch let error as APIError {
            XCTAssertEqual(error, .requestFailed)
            XCTAssertNil(viewModel.weatherItemPresentationModel)
        } catch {
            XCTFail("Unexpected error: \(error)")
            XCTAssertNil(viewModel.weatherItemPresentationModel)
        }
    }
}
