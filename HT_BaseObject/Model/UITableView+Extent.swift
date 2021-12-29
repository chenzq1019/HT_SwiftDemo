//
//  UITableView+Extent.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/28.
//

import Foundation
import UIKit

protocol HTTableProtocol {
    var mDataArray: [SectionBaseModel]? {get set}
    var impAction: HTTableViewAction? { get set }
    var cellArray: [HTCellBaseModelProtocl]? {get set}
}

extension UITableView: HTTableProtocol {
    private struct AssociatedKey {
        static var idDataArray: String = "identifierDataArray"
        static var idAction: String  = "identifierAction"
    }
    
    var cellArray: [HTCellBaseModelProtocl]? {
        get {
            if let section: SectionBaseModel = self.mDataArray?.first {
                return section.cellArray
            }
            return nil
        }
        set {
            var setion = SectionBaseModel()
            setion.cellArray = newValue
            self.mDataArray = [setion]
        }
    }
    
     var mDataArray: [SectionBaseModel]? {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKey.idDataArray) as? [SectionBaseModel])
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.idDataArray, newValue, .OBJC_ASSOCIATION_RETAIN)
            self.impAction?.dataArray = newValue
        }
    }
    
     var impAction: HTTableViewAction? {
        get {
            var action = (objc_getAssociatedObject(self, &AssociatedKey.idAction) as? HTTableViewAction)
            if action == nil {
                action = HTTableViewAction()
                self.delegate = action
                self.dataSource = action
                objc_setAssociatedObject(self, &AssociatedKey.idAction, action, .OBJC_ASSOCIATION_RETAIN)
            }
            return action
        }
        set {
            let action : HTTableViewAction? = newValue
            action?.dataArray = self.mDataArray
            self.dataSource = action
            self.delegate = action
            objc_setAssociatedObject(self, &AssociatedKey.idAction, action, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
