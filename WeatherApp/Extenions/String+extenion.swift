//
//  String+extenion.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Foundation

extension String {
  
    /// A computed property that returns the day of the week for a given date string in "yyyy-MM-dd" format.
    /// If the date is today, it returns "Today"; otherwise, it returns the full weekday name (e.g., "Monday").
    var getDayOfWeek: String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            if calendar.isDateInToday(date) {
                return "Today"
            } else {
                dateFormatter.dateFormat = "EEEE"
                return dateFormatter.string(from: date)
            }
        }
        return nil
    }
}
