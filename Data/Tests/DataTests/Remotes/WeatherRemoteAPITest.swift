//
//  WeatherRemoteAPITest.swift
//  Data
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
@testable import NetworkLayer
@testable import Data

final class WeatherRemoteAPITest: XCTestCase {

    var mockNetworkService: MockNetworkService!
    var networkService: NetworkService!
    var weatherRemoteAPI: WeatherRemoteAPI!

    override func setUp() {
        super.setUp()
        
        mockNetworkService = MockNetworkService()
        networkService = NetworkService(session: mockNetworkService)
        weatherRemoteAPI = DefaultWeatherRemoteAPI(networkService: networkService)
    }
    
    override func tearDown() {
        mockNetworkService = nil
        networkService = nil
        weatherRemoteAPI = nil
        super.tearDown()
    }
    
    func testFetchCurrentWeather_Success() async throws {
        let mockData =
                """
        {
            "location": {
                "name": "Giza"
            },
            "current": {
                "temp_c": 12.2,
                "temp_f": 54.0,
                "condition": {
                    "text": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                "wind_kph": 9.7
            },
            "forecast": {}
        }
        """.data(using: .utf8)
        
        let mockResponse = HTTPURLResponse(
            url: URL(string: "https://api.example.com/")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        mockNetworkService.mockData = mockData
        mockNetworkService.mockResponse = mockResponse
        
        let result = try await weatherRemoteAPI.fetchCurrentWeather(cityName: "Giza")
        
        XCTAssertEqual(result.location?.name, "Giza")
    }
    
    func testFetchCurrentWeatherSuccess_ButDataNotComingSuccess() async throws {
        let mockData =
                """
        {
            "location": {
                "name": "Giza"
            },
            "current": {
                "temp_c": 12.2,
                "temp_f": 54.0,
                "condition": {
                    "text": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                "wind_kph": 9.7
            },
            "forecast": {}
        }
        """.data(using: .utf8)
        
        let mockResponse = HTTPURLResponse(
            url: URL(string: "https://api.example.com/")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        mockNetworkService.mockData = mockData
        mockNetworkService.mockResponse = mockResponse
        
        let result = try await weatherRemoteAPI.fetchCurrentWeather(cityName: "Giza")
        
        XCTAssertNotEqual(result.location?.name, "London")
    }
    
    func testFetchCurrentWeather_DecodeFailure() async throws {
        let mockData =
                """
        {
            "location": {
                "name": "Giza"
            },
            "current": {
                "temp_c": "12.2",
                "temp_f": "54.0",
                "condition": {
                    "text": "Clear",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
                },
                "wind_kph": 9.7
            },
            "forecast": {}
        }
        """.data(using: .utf8)
        
        let mockResponse = HTTPURLResponse(
            url: URL(string: "https://api.example.com/")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        mockNetworkService.mockData = mockData
        mockNetworkService.mockResponse = mockResponse
        
        do {
            // When: Call API with invalid JSON
            _ = try await weatherRemoteAPI.fetchCurrentWeather(cityName: "Giza")
            XCTFail("Expected decoding error, but no error was thrown.")
        } catch let error as APIError {
            // Then: Ensure it throws a decoding error
            XCTAssertEqual(error, APIError.decodingError)
        }
    }
}

