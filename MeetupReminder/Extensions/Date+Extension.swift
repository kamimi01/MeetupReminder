//
//  Date+Extension.swift
//  MeetupReminder
//
//  Created by mikaurakawa on 2023/02/05.
//

import Foundation

extension Date {
    var components: DateComponents {
        let calendar = Calendar.current
        return DateComponents(
            calendar: Calendar.current,
            timeZone: TimeZone.current,
            year: calendar.component(.year, from: self),
            month: calendar.component(.month, from: self),
            day: calendar.component(.day, from: self),
            hour: calendar.component(.hour, from: self),
            minute: calendar.component(.minute, from: self),
            second: calendar.component(.second, from: self)
        )
    }
}
