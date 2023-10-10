//
//  ToDoListDB.swift
//  iOS-CoreData-Demo
//
//  Created by 王潇 on 2023/2/6.
//

import Foundation
import UIKit
import CoreData

class ToDoListDB {
    /// 获取所有列表
    static func queryList() -> [TodoList] {
        //  获取管理的数据上下文 对象
        if let app = UIApplication.shared.delegate as? AppDelegate {
            let context = app.persistentContainer.viewContext
            /// 查询数据
            let fetchList = NSFetchRequest<TodoList>.init(entityName: "TodoList")
            
            do {
                let Lists = try context.fetch(fetchList)
                return Lists
            } catch {
                print("查找失败")
            }
        }
        return []
    }
    
    /// 创建一条List
    static func createList(content: String, level: Int32) {
        //  获取管理数据的上下文
        if let app = UIApplication.shared.delegate as? AppDelegate {
            let context = app.persistentContainer.viewContext
            //  插入数据
            if let list = NSEntityDescription.insertNewObject(forEntityName: "TodoList", into: context) as? TodoList {
                list.id = UUID()
                list.content = content
                list.level = level
                
                if context.hasChanges {
                    do {
                        //  保存数据
                        try context.save()
                        print("保存数据成功")
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    //  通过UUID查询
    static func queryListWithId(id: UUID) -> TodoList {
        //  获取管理的数据上下文 对象
        if let app = UIApplication.shared.delegate as? AppDelegate {
            let context = app.persistentContainer.viewContext
            //  查询数据
            let featchLists = NSFetchRequest<TodoList>.init(entityName: "TodoList")
            //  条件查询
            featchLists.predicate = NSPredicate(format: "id  = \"\(id)\"")
            
            do {
                let list = try context.fetch(featchLists)
                return list[0]
            } catch {
                
            }
        }
        return TodoList()
    }
    
    //  修改一个列表的数据 读取->修改->保存
    static func updateList(id: UUID, content: String, level: Int32) {
        //  获取管理的数据上下文 对象
        if let app = UIApplication.shared.delegate as? AppDelegate {
            let context = app.persistentContainer.viewContext
            //  查询数据
            let fetchLists = NSFetchRequest<TodoList>.init(entityName: "TodoList")
            //  条件查询
            fetchLists.predicate = NSPredicate(format: "id = \"\(id)\"")
            
            do {
                let lists = try context.fetch(fetchLists)
                if !lists.isEmpty {
                    lists[0].content = content
                    lists[0].level = level
                    if context.hasChanges {
                        do {
                            //  保存数据
                            try context.save()
                            print("Update new List successful.")
                        } catch {
                            print(error)
                        }
                    }
                }
            } catch {
                
            }
        }
    }
    
    //  删除一个列表,根据id删除
    static func deleteList(id: UUID) {
        //  获取管理的数据上下文 对象
        if let app = UIApplication.shared.delegate as? AppDelegate {
            let context = app.persistentContainer.viewContext
            //  查询数据
            let fetchLists = NSFetchRequest<TodoList>.init(entityName: "TodoList")
            //  条件查询
            fetchLists.predicate = NSPredicate(format: "id = \"\(id)\"")
            
            do {
                let lists = try context.fetch(fetchLists)
                if !lists.isEmpty {
                    context.delete(lists[0])
                    if context.hasChanges {
                        do {
                            //  保存数据
                            try context.save()
                            print("delete \(id) successful.")
                        } catch {
                            print(error)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    //  删除所有列表
    static func deleteAll() {
        //  获取管理的数据上下文 对象
        if let app = UIApplication.shared.delegate as? AppDelegate {
            let context = app.persistentContainer.viewContext
            //  查询数据
            let fetchLists = NSFetchRequest<TodoList>.init(entityName: "TodoList")
            
            do {
                let lists = try context.fetch(fetchLists)
                if !lists.isEmpty {
                    for list in lists {
                        context.delete(list)
                    }
                    if context.hasChanges {
                        do {
                            //  保存数据
                            try context.save()
                            print("delele all successful.")
                        } catch {
                            print(error)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
