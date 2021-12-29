//
//  HTCellBaseModel.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/24.
//

import UIKit

 protocol HTCellBaseModelProtocl{
     var cellName: String {get}
     var height: CGFloat {get}
     var cellClass: AnyClass? {get}
     var itemSize: CGSize {get}
     var data: Any {get set}
}

class HTCellBaseModel: NSObject, HTCellBaseModelProtocl {
    var data: Any
    var height: CGFloat = 0
    var identify : String?
    var cellName : String

    var itemSize: CGSize = CGSize.zero
    var cellClass: AnyClass?
   
    
    required init(cellName: String, data: Any){
        self.cellName = cellName
        self.data = data
    }
    
    convenience init(cellClass: AnyClass, data: Any){
        let name = String(describing: cellClass)
        self.init(cellName: name, data:data)
        self.cellClass = cellClass
    }
}
