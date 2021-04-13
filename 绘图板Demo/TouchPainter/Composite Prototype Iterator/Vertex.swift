//
//  Vertex.swift
//  绘图板Demo
//
//  Created by 陈竹青 on 2021/1/13.
//

import UIKit

class Vertex: NSObject,Mark,NSCopying {

    
    var color: UIColor?
    var size: CGFloat?
    var location: CGPoint?
    var count: Int?
    var lastChild: Mark?

    override init() {
        super.init()
    }
    init(loaction: CGPoint?){
        super.init()
        self.location = loaction
       
    }
    func addMark(mark: Mark) {
        
    }
    
    func removeMark(mark: Mark) {
        
    }
    
    func childMarkAtIndex(index: Int) -> Mark? {
        return nil
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let vertextCopy = Vertex(loaction: location)
        return vertextCopy
    }
}
