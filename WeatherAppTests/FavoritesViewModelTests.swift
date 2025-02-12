//
//  FavoritesViewModelTests.swift
//  WeatherAppTests
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest

import XCTest
@testable import WeatherApp

final class FavoritesViewModelTests: XCTestCase {
    
    private var viewModel: FavoritesViewModel!
    private var mockUseCase: MockFavoritesCityLocalUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockFavoritesCityLocalUseCase()
        viewModel = FavoritesViewModel(useCase: mockUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func testFetchFavoritesCity_Success() async {
        
        let expectation = expectation(description: "Fetching favorite cities")
        
        Task {
            viewModel.onAppear()
            try? await Task.sleep(nanoseconds: 500_000_000) // 🔹 Wait 0.5s to allow updates
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 3.0)
                
        XCTAssertEqual(viewModel.weatherItemPresentationModel.count, 2)
    }
    
    func testFetchFavoritesCity_Failure() async {

        mockUseCase.shouldThrowError = true
        
        let expectation = expectation(description: "Fetching favorite cities")
        
        Task {
            viewModel.onAppear()
            try? await Task.sleep(nanoseconds: 500_000_000) // 🔹 Wait 0.5s to allow updates
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 3.0)

        XCTAssertTrue(viewModel.weatherItemPresentationModel.isEmpty)
    }
    
    func testRemoveCityFromFavorites_Success() async {

        mockUseCase.mockRemoveResult = true
                
        let expectation = expectation(description: "Fetching favorite cities")
        
        Task {
            viewModel.removeCityFromFavorites(id: 686859)
            try? await Task.sleep(nanoseconds: 500_000_000) // 🔹 Wait 0.5s to allow updates
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 3.0)

        XCTAssertTrue(mockUseCase.removeCityCalled)
    }
    
    func testRemoveCityFromFavorites_Failure() async {
        
        mockUseCase.shouldThrowError = true
        
        let expectation = expectation(description: "Fetching favorite cities")
        
        Task {
            viewModel.removeCityFromFavorites(id: 686859)
            try? await Task.sleep(nanoseconds: 500_000_000) // 🔹 Wait 0.5s to allow updates
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 3.0)
        
        XCTAssertTrue(mockUseCase.removeCityCalled)
    }
}
