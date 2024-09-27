//
//  DateHandler.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/13.
//

import Foundation

class DateHandler{
    static let dayMonthYearDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()
}
