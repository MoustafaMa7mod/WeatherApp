//
//  WeatherRepositoryTests.swift
//  Data
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest

import XCTest
@testable import Data
@testable import NetworkLayer

final class WeatherRepositoryTests: XCTestCase {

    var mockRemoteAPI: MockWeatherRemoteAPI!
    var repository: DefaultWeatherRepository!
    
    override func setUp() {
        super.setUp()
        mockRemoteAPI = MockWeatherRemoteAPI()
        repository = DefaultWeatherRepository(
            weatherRemoteAPI: mockRemoteAPI
        )
    }
    
    override func tearDown() {
        mockRemoteAPI = nil
        repository = nil
        super.tearDown()
    }
    
    func testWeatherInfo_Success() async throws {

        let result = try await repository.fetchCurrentWeather(cityName: "Giza")
        
        XCTAssertEqual(result.forecastItems.count, 2)
        XCTAssertEqual(result.temperatureCelsiusDegree, 12.2)
        XCTAssertEqual(result.temperatureFahrenheitDegree, 54.0)
        XCTAssertEqual(result.humidity, 77)
        XCTAssertEqual(result.windSpeed, 9.7)
    }
    
    func testWeatherInfoSuccess_ButDataNotMatch() async throws {

        let result = try await repository.fetchCurrentWeather(cityName: "Giza")
        XCTAssertNotEqual(result.temperatureCelsiusDegree, 54.0)
        XCTAssertNotEqual(result.temperatureFahrenheitDegree, 12.2)

    }
    
    func testSearchCountry_APIError() async {

        mockRemoteAPI.mockError = APIError.invalidResponse
        
        do {
            _ = try await repository.fetchCurrentWeather(cityName: "Giza")
            XCTFail("Expected APIError.invalidResponse, but no error was thrown.")
        } catch let error as APIError {
            
            XCTAssertEqual(error, APIError.invalidResponse)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testSearchCountry_DecodingError() async {

        mockRemoteAPI.mockError = APIError.decodingError
        
        do {
            _ = try await repository.fetchCurrentWeather(cityName: "Giza")
            XCTFail("Expected APIError.invalidResponse, but no error was thrown.")
        } catch let error as APIError {
            
            XCTAssertEqual(error, APIError.decodingError)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
