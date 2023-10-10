//
//  TodoList+CoreDataProperties.swift
//  
//
//  Created by 陈竹青 on 2023/8/15.
//
//

import Foundation
import CoreData


extension TodoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoList> {
        return NSFetchRequest<TodoList>(entityName: "TodoList")
    }

    @NSManaged public var content: String?
    @NSManaged public var id: UUID?
    @NSManaged public var level: Int32

}
