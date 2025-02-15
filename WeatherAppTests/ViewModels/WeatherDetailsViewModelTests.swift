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
        let expectation = expectation(description: "Weather info fetched")
        
        viewModel
            .weatherComponentViewModel?
            .delegate?
            .$weatherItem
            .dropFirst()
            .sink { model in
                if model != nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
        
        do {
            try await viewModel.weatherComponentViewModel?.fetchWeatherInfo(cityName: "Giza")
            await fulfillment(of: [expectation], timeout: 5.0)
            XCTAssertEqual(viewModel.weatherItem?.cityName , "Giza")

        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAddCityToFavorites_Success() async {
                
        viewModel.isFavorite = true

        do {
            let result = try await viewModel.addCityToFavorites(
                cityID: 686859,
                weatherItem: mockWeatherUseCase.weatherItemsModel()
            )
            XCTAssertTrue(viewModel.isFavorite)
            XCTAssertEqual(result, viewModel.isFavorite)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testRemoveCityFromFavorites_Success() async {
        
        mockFavoritesUseCase.mockRemoveResult = true
        viewModel.isFavorite = false

        do {
            let result = try await viewModel.addCityToFavorites(
                cityID: 686859,
                weatherItem: mockWeatherUseCase.weatherItemsModel()
            )
            XCTAssertFalse(viewModel.isFavorite)
            XCTAssertEqual(result, viewModel.isFavorite)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
