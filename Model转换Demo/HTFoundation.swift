//
//  HTFoundation.swift
//  Model转换Demo
//
//  Created by 陈竹青 on 2021/9/14.
//

import Foundation
import UIKit
 
class HEFoundation {
    
    static let set = NSSet(array: [
                                    NSURL.classForCoder(),
                                    NSDate.classForCoder(),
                                    NSValue.classForCoder(),
                                    NSData.classForCoder(),
                                    NSError.classForCoder(),
                                    NSArray.classForCoder(),
                                    NSDictionary.classForCoder(),
                                    NSString.classForCoder(),
                                    NSAttributedString.classForCoder()
                                  ])
//    static let  bundlePath = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
    static let bundlePath = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
    /*** 判断某个类是否是 Foundation中自带的类 */
    class func isClassFromFoundation(c:AnyClass)->Bool {
        var  result = false
        if c == NSObject.classForCoder(){
            result = true
        }else{
            set.enumerateObjects { (foundation, stop) in
                if  c.isSubclass(of: foundation as! AnyClass) {
                    result = true
                    stop.initialize(to: true)
                }
            }
        }
        return result
    }
    
    /** 很据属性信息， 获得自定义类的 类名*/
     /**
     let propertyType = String.fromCString(property_getAttributes(property))! 获取属性类型
     到这个属性的类型是自定义的类时， 会得到下面的格式： T+@+"+..+工程的名字+数字+类名+"+,+其他,
     而我们想要的只是类名，所以要修改这个字符串
     */
    class func getType( code:String)->String?{
        var codeStr = code
        if !codeStr.contains(bundlePath) {
            return nil
        }
        
        codeStr = String(Array(codeStr.split(separator: "\""))[1])
        if let range = codeStr.range(of: bundlePath){
            let firstIndex = range.upperBound
            let endIndex = codeStr.index(codeStr.startIndex, offsetBy: codeStr.count)
            codeStr = String(codeStr[firstIndex..<endIndex])
            var numStr = "" //类名前面的数字
            for c:Character in codeStr{
                if c <= "9" && c >= "0"{
                    numStr+=String(c)
                }
            }
            if let numRange = code.range(of: numStr){
                let start = numRange.upperBound
                let endIndex = codeStr.index(codeStr.startIndex, offsetBy: codeStr.count)
                codeStr = String(codeStr[start..<endIndex])
            }
            return bundlePath+"."+code
        }
        return nil
    }
}
 
