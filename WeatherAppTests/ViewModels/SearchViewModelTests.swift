//
//  SearchViewModelTests.swift
//  WeatherAppTests
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
import Combine
import NetworkLayer

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
        
        do {
            try await viewModel.searchCountry(name: "Lond")
            XCTAssertEqual(viewModel.items.count, 2)
            XCTAssertEqual(viewModel.items.first?.cityName, "London")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testSearchCity_Failure() async {
        mockSearchCountryUseCase.mockError = .requestFailed

        do {
            try await viewModel.searchCountry(name: "Lond")

            XCTFail("Expected an error but got success")
        } catch let error as APIError {
            XCTAssertEqual(error, .requestFailed)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testInitialViewModel_Creation() {
        
        let weatherDetailsVM = viewModel.initialViewModel(
            cityName: "Giza",
            cityID: 686859
        )
        
        XCTAssertNotNil(weatherDetailsVM)
    }
}
