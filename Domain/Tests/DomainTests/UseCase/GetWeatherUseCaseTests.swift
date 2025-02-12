//
//  GetWeatherUseCaseTests.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
@testable import NetworkLayer
@testable import Domain

final class GetWeatherUseCaseTests: XCTestCase {

    var mockRepository: MockWeatherRepository!
    var useCase: DefaultGetWeatherUseCase!

    override func setUp() {
        super.setUp()
        mockRepository = MockWeatherRepository()
        useCase = DefaultGetWeatherUseCase(repository: mockRepository)
    }

    override func tearDown() {
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }

    func testExecute_Success() async throws {
        let item = mockRepository.weatherItemModel()
        
        let result = try await useCase.execute(cityName: "Giza")
        
        XCTAssertEqual(
            result.temperatureCelsiusDegree,
            item.temperatureCelsiusDegree
        )
        
        XCTAssertEqual(result.cityID, item.cityID)
    }
    
    func testExecute_Failure() async {
        mockRepository.error = .requestFailed
        
        do {
            _ = try await useCase.execute(cityName: "Giza")
            XCTFail("Expected an error but got success")
        } catch let error as APIError {
            XCTAssertEqual(error, .requestFailed)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
