//
//  UICollectionView+Extent.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/28.
//

import Foundation
import UIKit

protocol HTCollectionProtocol {
    var mDataArray: [SectionBaseModel]? {get set}
    var impAction: HTCollectionViewAction? { get set}
//    var cellArray: [HTCellBaseModelProtocl]? {get set}
}

extension UICollectionView: HTCollectionProtocol {
    
    private struct AssociatedKey {
        static var idDataArray: String = "identifierDataArray"
        static var idAction: String  = "identifierAction"
    }
    
    var mDataArray: [SectionBaseModel]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.idDataArray) as? [SectionBaseModel]
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.idDataArray, newValue, .OBJC_ASSOCIATION_RETAIN)
            self.impAction?.dataArray = newValue
        }
    }
    
    var impAction: HTCollectionViewAction? {
        get {
            var action = objc_getAssociatedObject(self, &AssociatedKey.idAction) as? HTCollectionViewAction
            if action == nil {
                action = HTCollectionViewAction()
                self.delegate = action
                self.dataSource = action
                objc_setAssociatedObject(self, &AssociatedKey.idAction, action, .OBJC_ASSOCIATION_RETAIN)
            }
            return action
        }
        set {
            let action : HTCollectionViewAction? = newValue
            self.dataSource = action
            self.delegate = action
            objc_setAssociatedObject(self, &AssociatedKey.idAction, newValue, .OBJC_ASSOCIATION_RETAIN)
            
        }
    }
    
//    var cellArray: [HTCellBaseModelProtocl]? {
//        get {
//
//        }
//        set {
//
//        }
//    }
//
    
    
}
