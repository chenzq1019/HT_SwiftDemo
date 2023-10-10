//
//  TestViewModel.swift
//  UICollection布局切换
//
//  Created by 陈竹青 on 2023/6/30.
//

import Foundation


class TestViewModel: NSObject {
    
    var items: [TestModel]?
    
    func requestData(finish: @escaping (_ array:[TestModel]?) -> Void) {
        items = Array<TestModel>()
        for _ in 0..<20 {
            let model = TestModel()
            items?.append(model)
        }
        finish(items)
    }
    
    
    func transforLayoutType(type: TestModel.LayoutType){
        if let array = items {
            let result =  array.map { model in
                 model.layouType = type
                return model
            }
            items = result
        }
    }
}
