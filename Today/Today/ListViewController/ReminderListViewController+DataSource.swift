//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/27.
//

import Foundation
import UIKit


extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
    
    private var reminderStore: ReminderStore { ReminderStore.shared }
    
    //Add computed properties named reminderCompletedValue and reminderNotCompletedValue.
    var reminderCompletedValue: String {
        NSLocalizedString("Completed", comment: "Reminder  completed value")
    }
    var reminderNotCompletedValue: String {
        NSLocalizedString("Not completed", comment: "Reminder not completed value")
    }
    
    //To update the user interface, you need to tell the snapshot which reminders the user changed by calling the snapshot’s reloadItems(_:) method.
    func updateSnapshot(reloading idsThatChanged: [Reminder.ID] = []){
        let ids = idsThatChanged.filter{ id in filterReminders.contains(where: {$0.id == id})}
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(filterReminders.map{$0.id})
        if !ids.isEmpty{
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
        headerView?.progerss = progress
    }
    
    func cellRegistraionHandle(cell: UICollectionViewListCell, indexPath: IndexPath,id: Reminder.ID){
        let reminder = reminder(withId: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        cell.accessibilityCustomActions = [doneButtonAccessibilityAction(for: reminder)]
        //assign the correct localized string to the cell’s accessibilityValue.
        cell.accessibilityValue =  reminder.isComplete ? reminderCompletedValue : reminderNotCompletedValue
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration),
            .disclosureIndicator(displayed: .always)
        ]
        
        var backgroudConfiguration = cell.defaultBackgroundConfiguration()
        backgroudConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroudConfiguration
    }
    
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration{
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image =  UIImage(systemName: symbolName,withConfiguration: symbolConfiguration)
        let button = ReminderDoneButton()
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.id = reminder.id
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
    
    func reminder(withId id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withId: id)
        return reminders[index]
    }
    
    func updateReminder(_ reminder: Reminder){
        let index = reminders.indexOfReminder(withId: reminder.id)
        reminders[index] = reminder
    }
    
    func addReminder(_ reminder: Reminder){
        reminders.append(reminder)
    }
    
    func deleteReminder(with id:Reminder.ID){
        let index = reminders.indexOfReminder(withId: id)
        reminders.remove(at: index)
    }
    
    func completeReminder(withId id: Reminder.ID){
        var reminder = reminder(withId: id)
        reminder.isComplete.toggle()
        updateReminder(reminder)
        updateSnapshot(reloading: [id])
    }
    
    func prepareReminderStore(){
        Task{
            do{
                try await reminderStore.requestAccess()
                reminders = try await reminderStore.readAll()
                NotificationCenter.default.addObserver(self, selector: #selector(eventStoreChanged(_:)), name: .EKEventStoreChanged, object: nil)
            }catch TodayError.accessDenied, TodayError.accessRestricted {
                #if DEBUG
                reminders = Reminder.sampleDate
                #endif
            } catch {
                showError(error)
            }
            updateSnapshot()
        }
    }
    
    func reminderStoreChanged(){
        Task{
            reminders = try await reminderStore.readAll()
            updateSnapshot()
        }
    }
    
    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction{
        let name = NSLocalizedString("Toggle completion", comment: "Reminder done button accessibility label")
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completeReminder(withId: reminder.id)
            return true
        }
        return action
    }
}
