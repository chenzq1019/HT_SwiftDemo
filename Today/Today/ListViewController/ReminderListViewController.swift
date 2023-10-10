//
//  ViewController.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/27.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
//    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
//    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    var dataSource: DataSource!
    var reminders: [Reminder] = []
    var listStyle: ReminderListStyle = .today
    
    var filterReminders: [Reminder] {
        return reminders.filter { reminder in
            listStyle.shouldInclude(date: reminder.dueDate)
        }.sorted { $0.dueDate < $1.dueDate}
    }
    
    var progress: CGFloat {
        let chunkSize = 1.0 / CGFloat(filterReminders.count)
        let progress = filterReminders.reduce(0.0) {
            let chunk = $1.isComplete ? chunkSize : 0
                   return $0 + chunk
        }
        return progress
    }
    let listStyleSegmentControl = UISegmentedControl(items: [ReminderListStyle.today.name,ReminderListStyle.future.name,ReminderListStyle.all.name])

    var headerView: ProgressHeaderView?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshBackground()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .todayGradientFutureBegin
        // Do any additional setup after loading the view.
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistraionHandle)
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView:UICollectionView, indexPath:IndexPath, itemIdentifier:Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        let headerRegistration = UICollectionView.SupplementaryRegistration(elementKind: ProgressHeaderView.elementKind, handler: supplementaryRegistrationHandler)
        dataSource.supplementaryViewProvider = { supplementaryView, elementKind, indexPath in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_ :)))
        navigationItem.rightBarButtonItem = addButton
        if #available(iOS 16, *){
            navigationItem.style = .navigator
        }
        listStyleSegmentControl.selectedSegmentIndex = ReminderListStyle.today.rawValue
        navigationItem.titleView = listStyleSegmentControl
        listStyleSegmentControl.addTarget(self, action: #selector(didChangeListStyle(_:)), for: .valueChanged)
        
//        var snapshot = Snapshot()
//        snapshot.appendSections([0])
//        var reminderTitles = [String]()
//        for reminder in Reminder.sampleDate {
//            reminderTitles.append(reminder.title)
//        }
//        snapshot.appendItems(reminderTitles)
//        //将item的Identifier改成id
//        snapshot.appendItems(reminders.map{ $0.id })
//        dataSource.apply(snapshot)
        //将Snapshot封装到函数中
        updateSnapshot()
        collectionView.dataSource = dataSource
        
        prepareReminderStore()
    }
    
    func showError(_ error: Error){
        let alertTitle = NSLocalizedString("Error", comment: "Error alert title")
        let alert = UIAlertController(title: alertTitle, message: error.localizedDescription, preferredStyle: .alert)
        let actionTitle =  NSLocalizedString("OK", comment: "Alert OK button title")
        let action = UIAlertAction(title: actionTitle, style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }

    private func listLayout () -> UICollectionViewCompositionalLayout{
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.headerMode = .supplementary
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        //添加右滑
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard elementKind == ProgressHeaderView.elementKind, let progressView = view  as? ProgressHeaderView else{
            return
        }
        progressView.progerss = progress
    }
    
    func refreshBackground() {
        collectionView.backgroundColor = nil
        let backgroundView = UIView()
        let gradientlayer = CAGradientLayer.gradientlayer(for: listStyle, in: collectionView.frame)
        backgroundView.layer.addSublayer(gradientlayer)
        collectionView.backgroundView = backgroundView
    }
    
    private func pushDetailViewForReminder(withId id: Reminder.ID){
        let reminder = reminder(withId: id)
        let viewcontroller = ReminderViewController(reminder: reminder){ [weak self] reminder in
            self?.updateReminder(reminder)
            self?.updateSnapshot(reloading: [reminder.id])
        }
        navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        let id = reminders[indexPath.item].id
        let id = filterReminders[indexPath.item].id
        pushDetailViewForReminder(withId: id)
        return false
    }
    
    private func makeSwipeActions(for indexPath: IndexPath?) ->UISwipeActionsConfiguration?{
        guard let indexPath = indexPath , let id = dataSource.itemIdentifier(for: indexPath) else{return nil}
        let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) {
                   [weak self] _, _, completion in
            self?.deleteReminder(with: id)
            self?.updateSnapshot()
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    private func supplementaryRegistrationHandler(progressView: ProgressHeaderView,elementType:String, indexPath: IndexPath){
        headerView = progressView
    }

}

