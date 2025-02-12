//
//  SearchCountryUseCaseTests.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
@testable import NetworkLayer
@testable import Domain

final class SearchCountryUseCaseTests: XCTestCase {

    var mockRepository: MockSearchCountryRepository!
    var useCase: SearchCountryUseCase!

    override func setUp() {
        super.setUp()
        mockRepository = MockSearchCountryRepository()
        useCase = DefaultSearchCountryUseCase(repository: mockRepository)
    }

    override func tearDown() {
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }

    func testExecute_Success() async throws {
        let item = mockRepository.cityItems()
        
        let result = try await useCase.execute(name: "Lond")
        
        XCTAssertEqual(result.count, item.count)
        XCTAssertEqual(result.first?.cityName, item.first?.cityName)
    }
    
    func testExecute_Failure() async {
        mockRepository.error = .requestFailed
        
        do {
            _ = try await useCase.execute(name: "Giza")
            XCTFail("Expected an error but got success")
        } catch let error as APIError {
            XCTAssertEqual(error, .requestFailed)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
