//
//  SearchCountryRemoteAPITest.swift
//  Data
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
@testable import NetworkLayer
@testable import Data

final class SearchCountryRemoteAPITest: XCTestCase {

    var mockNetworkService: MockNetworkService!
    var networkService: NetworkService!
    var searchCountryAPI: DefaultSearchCountryRemoteAPI!

    override func setUp() {
        super.setUp()
        
        mockNetworkService = MockNetworkService()
        networkService = NetworkService(session: mockNetworkService)
        searchCountryAPI = DefaultSearchCountryRemoteAPI(networkService: networkService)
    }
    
    override func tearDown() {
        mockNetworkService = nil
        networkService = nil
        searchCountryAPI = nil
        super.tearDown()
    }

    
    func testSearchCountry_Success() async throws {
        let mockData = """
            [
                { "id": 2801268, "name": "London" },
                { "id": 279381, "name": "Londrina" },
                { "id": 2610925, "name": "Londonderry" }
            ]
            """.data(using: .utf8)
        
        let mockResponse = HTTPURLResponse(
            url: URL(string: "https://api.example.com/")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        mockNetworkService.mockData = mockData
        mockNetworkService.mockResponse = mockResponse
        
        let result = try await searchCountryAPI.searchCountry(name: "Lond")
        
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result.first?.name, "London")
    }
    
    func testSearchCountry_DecodeFailure() async throws {
        let mockData = """
            [
                { "id": 2801268, "name": "London" },
                { "id": 279381, "name": "Londrina" },
                { "name": 2610925, "name": "Londonderry" }
            ]
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
            _ = try await searchCountryAPI.searchCountry(name: "Lond")
            XCTFail("Expected decoding error, but no error was thrown.")
        } catch let error as APIError {
            // Then: Ensure it throws a decoding error
            XCTAssertEqual(error, APIError.decodingError)
        }
    }
}
