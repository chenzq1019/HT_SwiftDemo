//
//  Mark.swift
//  绘图板Demo
//
//  Created by 陈竹青 on 2021/1/13.
//

import Foundation
import UIKit

public protocol Mark: NSCopying {
    var color : UIColor? { get  }
    var size : CGFloat? { get  }
    var location: CGPoint? { get }
    var count : Int? { get }
    var lastChild : Mark? { get }
    
//    func copy() ->Self
    func addMark(mark: Mark)
    func removeMark(mark: Mark)
    func childMarkAtIndex(index: Int) -> Mark?
}
