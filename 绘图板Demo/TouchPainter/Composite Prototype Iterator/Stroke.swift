//
//  Stroke.swift
//  绘图板Demo
//
//  Created by 陈竹青 on 2021/1/13.
//

import UIKit

class Stroke: NSObject,Mark {

    
    var color: UIColor?
    
    var size: CGFloat?
    
    var location: CGPoint?  {
        get {
            if let children = children, children.count > 0 {
                return children.first?.location
            }
            return CGPoint.zero
        }
    }
    
    var count: Int? {
        if let children = children {
            return children.count
        }
        return nil
    }
    
    var lastChild: Mark? {
        get {
            if let children = children {
                return children.last
            }
            return nil
        }
    }
    
    var children : [Mark]? = [Mark]()
    
    func addMark(mark: Mark) {
        children?.append(mark)
    }
    
    func removeMark(mark: Mark) {
        if let children = children {
            var mutlchild = children
            mutlchild.removeAll { (mark1: Mark) -> Bool in
                return mark1 === mark
            }
            
        }
    }
    
    func childMarkAtIndex(index: Int) -> Mark? {
        if let children = children,index >= children.count {
            return children[index]
        }
        return nil
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let strokeCopy = Stroke()
        if let color = color {
            strokeCopy.color = UIColor(cgColor: color.cgColor)
        }
        if let children = children {
            for child in children {
                let childCopy = child.copy()
                strokeCopy.addMark(mark: childCopy as! Mark)
            }
            
        }
        return strokeCopy
    }
    
    
}
