//
//  StringExtensionTests.swift
//  WeatherAppTests
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import XCTest
@testable import WeatherApp

final class StringExtensionTests: XCTestCase {
    
    func testGetDayOfWeek_WithValidDate() {

        let dateString = "2024-02-15"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "EEEE"
        let expectedDay = date.map { dateFormatter.string(from: $0) }
        
        let result = dateString.getDayOfWeek
        XCTAssertEqual(result, expectedDay)
    }
    
    func testGetDayOfWeek_WithTodayDate() {

        let todayDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = dateFormatter.string(from: todayDate)
        
        let result = todayString.getDayOfWeek
        XCTAssertEqual(result, "Today")
    }
    
    func testGetDayOfWeek_WithInvalidDate() {

        let invalidDateString = "Invalid-Date"
        
        let result = invalidDateString.getDayOfWeek
        XCTAssertNil(result)
    }
    
    func testGetDayOfWeek_WithEmptyString() {
        let emptyString = ""
        
        let result = emptyString.getDayOfWeek
        XCTAssertNil(result)
    }
}
