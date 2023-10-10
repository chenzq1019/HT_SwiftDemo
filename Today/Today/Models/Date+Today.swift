//
//  Date+Today.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/27.
//

import Foundation


extension Date {
    var dayAndTimeText: String {
        let timeText = formatted(date: .omitted, time: .standard)
        //判断是否是今天
        if Locale.current.calendar.isDateInToday(self){
            let timeFormt = NSLocalizedString("Today at %@", comment: "Today at time format string")
            return String(format: timeFormt, timeText)
        }else{
            //The formatted(_:) method uses a custom date format style to create a representation of the date that is appropriate for the user’s current locale.
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            let dateAndTimeFormat = NSLocalizedString("%@ at %@", comment: "Date and time format string")
            return String(format: dateAndTimeFormat, dateText ,timeText)
        }
    }
    
    var dayText: String {
        if Locale.current.calendar.isDateInToday(self) {
            return NSLocalizedString("Today", comment: "Today due date description")
        }else{
            //This formatted method accepts a custom date style that includes only the month, day, and weekday.
            return formatted(.dateTime.month().day().weekday(.wide))
        }
    }
}
