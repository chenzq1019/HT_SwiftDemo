//
//  Reminder+EKReminder.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/29.
//

import Foundation
import EventKit

extension Reminder {
    
    init(with ekReminder: EKReminder) throws {
        guard let dueDate = ekReminder.alarms?.first?.absoluteDate else{ throw TodayError.reminderHasNoDueDate}
        id = ekReminder.calendarItemIdentifier
        title = ekReminder.title
        self.dueDate = dueDate
        notes = ekReminder.notes
        isComplete = ekReminder.isCompleted
    }
}
