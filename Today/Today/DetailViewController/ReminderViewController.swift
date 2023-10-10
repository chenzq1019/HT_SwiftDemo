//
//  ReminderViewController.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/27.
//

import UIKit

private let reuseIdentifier = "Cell"

class ReminderViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section,Row>
    var reminder: Reminder {
        didSet {
            onChanged(reminder)
        }
    }
    //This temporary reminder stores the edits until the user chooses to save or discard them.
    var workingReminder: Reminder
    //add an isAddingNewReminder property, and set its initial value to fals
    var isAddingNewReminder: Bool = false
    var onChanged: (Reminder) -> Void
    
    private var datasource: DataSource!
    init(reminder: Reminder,onChanged: @escaping (Reminder) ->Void) {
        self.reminder = reminder
        self.workingReminder = reminder
        self.onChanged = onChanged
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        listConfiguration.headerMode = .firstItemInSection
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(collectionViewLayout: listLayout)
    }
                                                                    
                                                                    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        datasource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        if #available(iOS 16, *){
            navigationItem.style = .navigator
        }
        
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        navigationItem.rightBarButtonItem = editButtonItem
        updateSnapshotForViewing()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            prepareForEditing()
        }else {
            if isAddingNewReminder {
//                prepareForViewing()
                onChanged(workingReminder)
            }else {
                prepareForViewing()
            }
        }
    }
    
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
        case (_,.header(let title)):
//            var contentConfiguration = cell.defaultContentConfiguration()
//            contentConfiguration.text = title
//            cell.contentConfiguration = contentConfiguration
            cell.contentConfiguration = headerConfiguration(for: cell, with: title)
        case (.view, _):
            
//            var contentConfiguration = cell.defaultContentConfiguration()
//            contentConfiguration.text = text(for: row)
//            contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
//            contentConfiguration.image = row.image
//            cell.contentConfiguration = contentConfiguration
            cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
        case (.title,.editableText(let title)):
            cell.contentConfiguration = titleConfiguraton(for: cell, with: title!)
        case (.date,.editableDate(let date)):
            cell.contentConfiguration = datePickConfiguration(for: cell, with: date)
        case (.notes, .editableText(let notes)):
            cell.contentConfiguration = notesConfiguration(for: cell, with: notes)
        default:
            fatalError("Unexpected combination of section and row.")
        }
        cell.tintColor = .todayPrimaryTint
    }
    

    
    private func updateSnapshotForEditing(){
        var snapshot = SnapShot()
        snapshot.appendSections([.title,.date,.notes])
        snapshot.appendItems([.header(Section.title.name),.editableText(reminder.title)],toSection: .title)
        snapshot.appendItems([.header(Section.date.name),.editableDate(reminder.dueDate)],toSection: .date)
        snapshot.appendItems([.header(Section.notes.name),.editableText(reminder.notes)],toSection: .notes)
        datasource.apply(snapshot)
    }
    
    @objc func didCancelEdit(){
        workingReminder = reminder
        setEditing(false, animated: true)
    }
    
    private func prepareForEditing(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelEdit))
        updateSnapshotForEditing()
    }
    
    private func updateSnapshotForViewing(){
        var snapShot = SnapShot()
        snapShot.appendSections([.view])
        snapShot.appendItems([Row.header(""),Row.title,Row.date,Row.time,Row.notes],toSection: .view)
        datasource.apply(snapShot)
    }
    
    private func prepareForViewing(){
        navigationItem.leftBarButtonItem = nil
        if workingReminder != reminder {
            reminder = workingReminder
        }
        updateSnapshotForViewing()
    }
    
    private func section(for indexPath: IndexPath) -> Section{
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching secton")
        }
        return section
    }
                                                        
}
