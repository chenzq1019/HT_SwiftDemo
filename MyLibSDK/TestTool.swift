//
//  TestTool.swift
//  MyLibSDK
//
//  Created by 陈竹青 on 2021/1/11.
//

import UIKit
//注意，需要导出的类必选添加open，或者public
open class TestTool: NSObject {
    var toolType : String?
    
    public override init() {
        super.init()
    }
    //添加一个新的初始化方法，并支持OC调用
    @objc public init(name type: String){
        super.init()
        toolType = type
    }
    //内部方法
    func sayLibSDKHello() -> Void {
        print("Hello")
    }
    //swift暴露方法
    public func sayHelloToSwift(){
        print("Hello")
    }
    //swift暴露方法
    public func showToolTypeSwift(){
        if let type = self.toolType {
            print("This Tool Type is \(type)")
        }
        
    }
    //oc暴露方法
    @objc public func sayHelloToOC() ->Void{
        print("Hello")
    }
    //oc暴露方法
    @objc public func showToolTypeOC(){
        if let type = self.toolType {
            print("This Tool Type is \(type)")
        }
    }
}
