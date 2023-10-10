//
//  CoreDataManager.swift
//  CoreDataDemo
//
//  Created by 陈竹青 on 2023/8/15.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    
//    static let manager = CoreDataManager()
//    private let StoreURL = URL.init(string: NSHomeDirectory() + "/Documents")?.appendingPathExtension("Student.student")
//    var managedObjectContext: NSManagedObjectContext?
//    override init() {
//        super.init()
//        managedObjectContext = createStudentmainContext()
//    }
//
//    public func createStudentmainContext() -> NSManagedObjectContext{
//        let bundles = [Bundle(for: Student.self)]
//
//        guard let model = NSManagedObjectModel.mergedModel(from: bundles) else {
//            fatalError("model not found")
//        }
//
//        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
//        try! psc.addPersistentStore(type: .sqlite, at: StoreURL ?? nil)
//
//        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//        context.persistentStoreCoordinator = psc
//        return context
//    }
}
