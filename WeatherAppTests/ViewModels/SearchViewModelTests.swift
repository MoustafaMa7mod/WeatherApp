//
//  SearchViewModelTests.swift
//  WeatherAppTests
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
import Combine
@testable import WeatherApp

final class SearchViewModelTests: XCTestCase {

    var viewModel: SearchViewModel!
    var mockSearchCountryUseCase: MockSearchCountryUseCase!
    var mockGetWeatherUseCase: MockGetWeatherUseCase!
    var mockFavoritesCityLocalUseCase: MockFavoritesCityLocalUseCase!
    var cancellable: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        
        mockSearchCountryUseCase = MockSearchCountryUseCase()
        mockGetWeatherUseCase = MockGetWeatherUseCase()
        mockFavoritesCityLocalUseCase = MockFavoritesCityLocalUseCase()
        
        viewModel = SearchViewModel(
            searchCountryUseCase: mockSearchCountryUseCase,
            getWeatherUseCase: mockGetWeatherUseCase,
            favoritesCityLocalUseCase: mockFavoritesCityLocalUseCase
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockSearchCountryUseCase = nil
        mockGetWeatherUseCase = nil
        mockFavoritesCityLocalUseCase = nil
        cancellable.removeAll()
        super.tearDown()
    }
    
    func testSearchCity_Success() async {
        
        viewModel.cityName = "Lond"

        let expectation = expectation(description: "Fetching favorite cities")
        
        Task {
            viewModel.startSearch()
            try? await Task.sleep(nanoseconds: 1000_000_000) // 🔹 Wait 0.5s to allow updates
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 3.0)

        XCTAssertEqual(viewModel.items.count, 2)
        XCTAssertEqual(viewModel.items.first?.cityName, "London")
    }
    
    func testSearchCity_Failure() async {
        mockSearchCountryUseCase.mockError = .requestFailed
        
        viewModel.cityName = "Lond"
        
        let expectation = expectation(description: "Fetching favorite cities")
        
        Task {
            viewModel.startSearch()
            try? await Task.sleep(nanoseconds: 1000_000_000) // 🔹 Wait 0.5s to allow updates
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 3.0)

        XCTAssertEqual(viewModel.items.count, 0) // Expect no items due to error
    }
    
    func testInitialViewModel_Creation() {
        
        let weatherDetailsVM = viewModel.initialViewModel(
            cityName: "Giza",
            cityID: 686859
        )
        
        XCTAssertNotNil(weatherDetailsVM)
    }
}
