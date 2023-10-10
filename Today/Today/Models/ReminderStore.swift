//
//  ReminderStore.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/29.
//

import Foundation
import EventKit

final class ReminderStore{
    static let shared = ReminderStore()
    private let ekStore = EKEventStore()
    var isAuailable: Bool {
        EKEventStore.authorizationStatus(for: .reminder) == .authorized
    }
    
    func requestAccess() async throws {
        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status{
        case .authorized:
            return
        case .restricted:
            throw TodayError.accessRestricted
        case .notDetermined:
            let accessGranted = try await ekStore.requestAccess(to: .reminder)
            guard accessGranted else {throw TodayError.accessDenied}
        case .denied:
            throw TodayError.accessDenied
        @unknown default:
            throw TodayError.unknow
        }
    }
    
    func readAll() async throws -> [Reminder] {
        guard isAuailable else { throw TodayError.accessDenied}
        //这个谓词将结果缩小到只包含提醒项。如果您选择，您可以进一步缩小结果到特定日历中的提醒。
        let predicate = ekStore.predicateForReminders(in: nil)
        let ekReminder = try await ekStore.reminders(matching: predicate)
        let reminders : [Reminder] = try ekReminder.compactMap{ ekreminder in
            do {
                return try Reminder(with: ekreminder)
            }catch TodayError.reminderHasNoDueDate{
                return nil
            }
        }
        return reminders
    }
    private func read(with id: Reminder.ID) throws -> EKReminder{
        guard let ekReminder = ekStore.calendarItem(withIdentifier: id) as? EKReminder else {
                    throw TodayError.failedReadingCalenarItem
                }
        return ekReminder
    }
    
    //您不会在所有情况下都使用此方法返回的标识符。@discardableResult属性指示编译器在调用站点没有捕获返回值的情况下忽略警告。
    @discardableResult
     func save(_ reminder: Reminder) throws -> Reminder.ID {
         guard isAuailable else {
                     throw TodayError.accessDenied
                 }
         let ekReminder: EKReminder
         do {
            ekReminder = try read(with: reminder.id)
         }catch {
            ekReminder = EKReminder(eventStore: ekStore)
        }
         ekReminder.update(using: reminder, in: ekStore)
         try ekStore.save(ekReminder, commit: true)
         return ekReminder.calendarItemIdentifier
     }

}
