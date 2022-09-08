//
//  CalendarViewModel.swift
//  TodoList
//
//  Created by Ruan Jansen on 2022/09/08.
//

import Foundation

class CalendarViewModel: ObservableObject{
    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    init(){
        fetchCurrntWeek()
    }
    
    func fetchCurrntWeek(){
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else{
            return
        }
        
        (1...7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
        }
    }
    
    func extractDate(date: Date, format: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func isToday(date: Date) -> Bool{
        let calnedar = Calendar.current
        return calnedar.isDate(currentDay, inSameDayAs: date)
    }
}
