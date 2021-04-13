//
//  Dot.swift
//  绘图板Demo
//
//  Created by 陈竹青 on 2021/1/13.
//

import UIKit

class Dot: Vertex {
    override func copy(with zone: NSZone? = nil) -> Any {
        let dotCopy = Dot(loaction: location)
        dotCopy.size = size
        return dotCopy
    }
}
