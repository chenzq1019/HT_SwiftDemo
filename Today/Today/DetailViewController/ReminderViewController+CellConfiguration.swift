//
//  ReminderViewController+CellConfiguration.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/28.
//

import Foundation
import UIKit


extension ReminderViewController{
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration{
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        return contentConfiguration
    }
    
    func headerConfiguration(for cell: UICollectionViewListCell, with title:String) -> UIListContentConfiguration{
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        return contentConfiguration
    }
    
    func titleConfiguraton(for cell: UICollectionViewListCell, with tile: String?) -> TextFieldContentView.Configuration{
        var contentConfiguration = cell.textFieldConfiguration()
        contentConfiguration.text = tile
        contentConfiguration.onChange = {[weak self] title in
            self?.workingReminder.title = title
        }
        return contentConfiguration
    }
    
    func datePickConfiguration(for cell: UICollectionViewListCell,with date:Date) -> DatePickerContentView.Configuration {
        var contentConfiguration = cell.datePickerConfiguration()
        contentConfiguration.date = date
        contentConfiguration.onChanged = {[weak self] date in
            self?.workingReminder.dueDate = date
        }
        return contentConfiguration
    }
    
    func notesConfiguration(for cell: UICollectionViewListCell, with notes: String?) -> TextViewContentView.Configuration{
        var contentConfiguration = cell.textViewConfiguration()
        contentConfiguration.text = notes
        contentConfiguration.onChanged = {[weak self] notes in
            self?.workingReminder.notes = notes
        }
        return contentConfiguration
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.dayAndTimeText
        case .title: return reminder.title
        default: return nil
        }
    }
}
