//
//  FavoritesCityLocalUseCaseTests.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
@testable import Domain

final class FavoritesCityLocalUseCaseTests: XCTestCase {
    
    var mockRepository: MockFavoritesCityLocalRepository!
    var useCase: DefaultFavoritesCityLocalUseCase!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockFavoritesCityLocalRepository()
        useCase = DefaultFavoritesCityLocalUseCase(local: mockRepository)
    }
    
    override func tearDown() {
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testAddCityToFavorites_Success() async throws {
        let addedWeatherItem = mockRepository.addedWeatherItem()
        
        let result = try await useCase.addCityToFavorites(
            item: addedWeatherItem,
            cityName: "Giza",
            cityID: 686859
        )
        
        XCTAssertTrue(result, "Adding city should succeed")
    }
    
    func testFetchFavoritesCities_Success() async throws {
        let expectedItems = mockRepository.weatherItemsModel()
        
        let result = try await useCase.fetchFavoritesCities()
        
        XCTAssertEqual(result.count, expectedItems.count)
        XCTAssertEqual(result.first?.weatherCondition, expectedItems.first?.weatherCondition)
    }
    
    func testAddCityToFavorites_Failure() async throws {
        mockRepository.mockSaveSuccess = false
        
        let addedWeatherItem = mockRepository.addedWeatherItem()

        let result = try await useCase.addCityToFavorites(
            item: addedWeatherItem,
            cityName: "Giza",
            cityID: 686859
        )
        
        XCTAssertFalse(result, "Adding city should fail")
    }
    
    func testRemoveCityFavorites_Success() async throws {
        let result = try await useCase.removeCityFavorites(id: 686859)
        
        XCTAssertTrue(result, "Removing city should succeed")
    }
    
    func testRemoveCityFavorites_Failure() async throws {
        mockRepository.mockDeleteSuccess = false
        
        let result = try await useCase.removeCityFavorites(id: 123)
        
        XCTAssertFalse(result, "Removing city should fail")
    }
}
