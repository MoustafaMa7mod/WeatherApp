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
        
        do {
            try await viewModel.fetchFavoritesCity()
            XCTAssertEqual(viewModel.weatherItemPresentationModel.count, 2)

        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testFetchFavoritesCity_Failure() async {

        mockUseCase.shouldThrowError = true
        
        do {
            try await viewModel.fetchFavoritesCity()
            XCTFail("Expected an error but got success")

        } catch let error {
            XCTAssertEqual(error.localizedDescription, "Failed to fetch FavoritesCities")
        }
    }
    
    func testRemoveCityFromFavorites_Success() async {
        mockUseCase.mockRemoveResult = true
        
        do {
            let result = try await viewModel.removeFavorites(id: 686859)
            XCTAssertTrue(mockUseCase.removeCityCalled)
            XCTAssertEqual(result, mockUseCase.removeCityCalled)

        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testRemoveCityFromFavorites_Failure() async {
        mockUseCase.shouldThrowError = true

        do {
            _ = try await viewModel.removeFavorites(id: 686859)
            XCTFail("Expected an error but got success")

        } catch let error {
            XCTAssertEqual(error.localizedDescription, "Failed to remove City from Favorites")
        }
    }
}
