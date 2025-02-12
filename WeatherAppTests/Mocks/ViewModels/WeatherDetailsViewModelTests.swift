//
//  WeatherDetailsViewModelTests.swift
//  WeatherAppTests
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherDetailsViewModelTests: XCTestCase {
    
    private var viewModel: WeatherDetailsViewModel!
    private var mockWeatherUseCase: MockGetWeatherUseCase!
    private var mockFavoritesUseCase: MockFavoritesCityLocalUseCase!
    private var cancellable: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        
        mockWeatherUseCase = MockGetWeatherUseCase()
        mockFavoritesUseCase = MockFavoritesCityLocalUseCase()
        viewModel = WeatherDetailsViewModel(
            getWeatherUseCase: mockWeatherUseCase,
            favoritesCityLocalUseCase: mockFavoritesUseCase,
            cityName: "Giza",
            cityID: 686859
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockWeatherUseCase = nil
        mockFavoritesUseCase = nil
        super.tearDown()
    }
    
    func testViewModelInitialization() {
        
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(viewModel.weatherComponentViewModel)
    }
    
    func testFetchWeatherInfo_Success() async {
        
        let expectation = expectation(description: "Fetching weather succeeds")

        Task {
            viewModel.weatherComponentViewModel?.fetchWeatherInfo(cityName: "Giza")
            try? await Task.sleep(nanoseconds: 1000_000_000) // 🔹 Wait 0.5s to allow updates
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 3.0)

        XCTAssertEqual(viewModel.weatherItem?.cityName, "Giza")
    }
    
    func testAddCityToFavorites_Success() async {
                
        let expectation = expectation(description: "Fetching favorite cities")
        
        Task {
            viewModel.isFavorite = true
            viewModel.weatherItem = mockWeatherUseCase.weatherItemsModel()
            viewModel.addCityToFavoritesTapped()
            try? await Task.sleep(nanoseconds: 1000_000_000) // 🔹 Wait 0.5s to allow updates
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 3.0)
        
        XCTAssertTrue(viewModel.isFavorite)
    }
    
    func testRemoveCityFromFavorites_Success() async {
        
        let expectation = expectation(description: "Fetching favorite cities")
        
        Task {
            
            viewModel.weatherItem = mockWeatherUseCase.weatherItemsModel()
            mockFavoritesUseCase.mockRemoveResult = true
            viewModel.isFavorite = true
            viewModel.addCityToFavoritesTapped()
            try? await Task.sleep(nanoseconds: 1000_000_000) // 🔹 Wait 0.5s to allow updates
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 3.0)
        XCTAssertFalse(viewModel.isFavorite)
    }
}
