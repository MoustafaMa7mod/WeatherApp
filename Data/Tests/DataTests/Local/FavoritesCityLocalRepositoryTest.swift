//
//  FavoritesCityLocalRepositoryTest.swift
//  Data
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
import CoreData
@testable import Data
@testable import Domain
@testable import NetworkLayer

final class FavoritesCityLocalRepositoryTest: XCTestCase {
    
    var persistenceController: PersistenceController!
    var repository: DefaultFavoritesCityLocalRepository!
    
    override func setUp() {
        super.setUp()
        persistenceController = PersistenceController(inMemory: true)
        repository = DefaultFavoritesCityLocalRepository(persistenceController: persistenceController)
    }
    
    override func tearDown() {
        persistenceController = nil
        repository = nil
        super.tearDown()
    }

    func testSaveFavoriteCity_Success() async {
        
        let item = weatherItem()
        
        let success = await repository.save(
            item: item,
            cityName: "Giza",
            cityID: 686859
        )
        
        XCTAssertTrue(success, "Saving the favorite city should succeed")
        
        let fetchedCities = await repository.fetchFavoritesCities()
        XCTAssertEqual(fetchedCities.count, 1)
        XCTAssertEqual(fetchedCities.first?.cityName, "Giza")
        XCTAssertEqual(fetchedCities.first?.cityID, 686859)
    }
    
    func testFetchFavoritesCities_Empty() async {
        
        let fetchedCities = await repository.fetchFavoritesCities()
        
        XCTAssertTrue(fetchedCities.isEmpty)
    }
    
    func testDeleteFavoriteCity_Success() async {
        
        let result = await repository.save(
            item: weatherItem(),
            cityName: "Giza",
            cityID: 686859
        )
        
        var fetchedCities = await repository.fetchFavoritesCities()
        XCTAssertEqual(fetchedCities.count, 1)
        XCTAssertTrue(result)
        
        let deleteSuccess = await repository.deleteItem(id: 686859)
        
        XCTAssertTrue(deleteSuccess, "Deleting a saved item should succeed")
        
        fetchedCities = await repository.fetchFavoritesCities()
        XCTAssertTrue(fetchedCities.isEmpty)
    }
    
    func testDeleteNonExistingCity() async {
        let deleteSuccess = await repository.deleteItem(id: 686859)
        
        XCTAssertTrue(deleteSuccess, "Deleting a non-existing city should return true but have no effect")
    }

    private func weatherItem() -> WeatherItem {
        WeatherItem(
            cityID: 686859,
            cityName: "Giza",
            temperatureCelsiusDegree: 12.2,
            temperatureFahrenheitDegree: 54.0,
            humidity: 77,
            windSpeed: 9.7,
            weatherCondition: "Clear",
            icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"
        )
    }
}
