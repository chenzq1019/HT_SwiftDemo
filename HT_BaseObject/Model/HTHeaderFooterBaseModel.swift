//
//  HTHeaderFooterBaseModel.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/24.
//

import Foundation
import UIKit

protocol HTHeaderFooterModelProtocol {
    var viewName : String {get}
    var viewClass: AnyClass? {get}
    var itemSize: CGSize? {get}
//    func defaultSize() -> CGSize
//    func defaultHeight() -> CGFloat
}


class HTHeaderFooterBaseModel : HTHeaderFooterModelProtocol {
    var viewName: String
    var height: CGFloat?
    var itemSize: CGSize?
    var data: Any?
    var viewClass: AnyClass?
    
    required init(viewName:String,data: Any?){
        self.viewName = viewName
        self.data = data
    }
    
    convenience init(viewClass:AnyClass,data: Any?){
        let name = String(describing: viewClass)
        self.init(viewName: name, data: data)
        self.viewClass = viewClass
    }
    
//    func defaultHeight() -> CGFloat {
//        return self.height ?? 0
//    }
//    
//    func defaultSize() -> CGSize {
//        return self.itemSize ?? CGSize.zero
//    }
}
