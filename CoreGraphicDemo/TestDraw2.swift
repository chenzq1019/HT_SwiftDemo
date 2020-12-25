//
//  TestDraw2.swift
//  CoreGraphicDemo
//
//  Created by 陈竹青 on 2020/12/25.
//

import UIKit

class TestDraw2: UIView {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: 10, y: 0))
        context?.addLine(to: CGPoint(x: 10, y: 100))
        context?.addLine(to: CGPoint(x: 200, y: 100))
        
        context?.closePath()
        UIColor.red.setStroke()
        UIColor.yellow.setFill()
        context?.drawPath(using: .fillStroke)
    }

}
