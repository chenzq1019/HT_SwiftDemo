//
//  ReminderListController+Actions.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/27.
//

import Foundation
import UIKit


extension ReminderListViewController {
    
    @objc func eventStoreChanged(_ notification: Notification){
        reminderStoreChanged()
    }
    
    @objc func didPressDoneButton(_ sender: ReminderDoneButton){
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
    
    @objc func didPressAddButton(_ sneder: UIBarButtonItem){
        let reminder = Reminder(title: "", dueDate: Date.now)
        let viewController = ReminderViewController(reminder: reminder) { [weak self] reminder in
            self?.addReminder(reminder)
            self?.updateSnapshot()
            self?.dismiss(animated: true)
        }
        viewController.isAddingNewReminder = true
        viewController.setEditing(true, animated: false)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelAdd(_:)))
        viewController.navigationItem.title = NSLocalizedString("Add Reminder", comment: "Add Reminder view controller title")
        let navigationControlelr = UINavigationController(rootViewController: viewController)
        present(navigationControlelr, animated: true)
    }
    
    @objc func didCancelAdd(_ sender:UIBarButtonItem){
        dismiss(animated: true)
    }
    
    @objc func didChangeListStyle(_ sender: UISegmentedControl){
        listStyle = ReminderListStyle(rawValue: sender.selectedSegmentIndex) ?? .today
        updateSnapshot()
        refreshBackground()
    }
}
