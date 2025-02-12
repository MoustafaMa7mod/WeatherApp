//
//  SearchCountryRepositoryTests.swift
//  Data
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
@testable import Data
@testable import NetworkLayer

final class SearchCountryRepositoryTests: XCTestCase {

    var mockRemoteAPI: MockSearchCountryRemoteAPI!
    var repository: DefaultSearchCountryRepository!
    
    override func setUp() {
        super.setUp()
        mockRemoteAPI = MockSearchCountryRemoteAPI()
        repository = DefaultSearchCountryRepository(
            searchCountryRemoteAPI: mockRemoteAPI
        )
    }
    
    override func tearDown() {
        mockRemoteAPI = nil
        repository = nil
        super.tearDown()
    }
    
    func testSearchCountry_Success() async throws {

        let result = try await repository.searchCountry(name: "Lond")
        
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.cityName, "London")
        XCTAssertEqual(result.last?.cityName, "Londrina")
    }
    
    func testSearchCountrySuccess_ButDataNotMatch() async throws {

        let result = try await repository.searchCountry(name: "Giza")
        XCTAssertEqual(result.first?.cityName, "London")
    }
    
    func testSearchCountry_APIError() async {

        mockRemoteAPI.mockError = APIError.invalidResponse
        
        do {
            _ = try await repository.searchCountry(name: "Lond")
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
            _ = try await repository.searchCountry(name: "Lond")
            XCTFail("Expected APIError.invalidResponse, but no error was thrown.")
        } catch let error as APIError {
            
            XCTAssertEqual(error, APIError.decodingError)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
