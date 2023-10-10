//
//  ReminderViewController+Section.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/28.
//

import Foundation

extension ReminderViewController{
    enum Section: Int, Hashable {
        case view
        case title
        case date
        case notes
        
        var name: String {
            switch self {
            case .view: return ""
            case .title: return NSLocalizedString("Title", comment: "Title section name")
            case .date: return NSLocalizedString("Date", comment: "Date section name")
            case .notes: return NSLocalizedString("Notes", comment: "Notes section name")
            }
        }
    }
}
