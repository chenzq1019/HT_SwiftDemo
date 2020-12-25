//
//  HTCommonDrawView.swift
//  CoreGraphicDemo
//
//  Created by 陈竹青 on 2020/12/25.
//

import UIKit

class TestDraw1: UIView {

    override func draw(_ rect: CGRect) {
        //获取图形上下文
        let context = UIGraphicsGetCurrentContext()
        //创建路劲对象
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 20, y: 0))
        path.addLine(to: CGPoint(x: 20, y: 100))
        path.addLine(to: CGPoint(x: 300, y: 100))
        
        //添加路径到图形上下文中
        context?.addPath(path)
        
        //设置图形上下文状态属性
        context?.setStrokeColor(UIColor(red: 0.1, green: 0.5, blue: 0, alpha: 1).cgColor)
        context?.setFillColor(UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor)
        context?.setLineWidth(2.0)
        context?.setLineCap(.round) //设置顶点样式
        context?.setLineJoin(.round)//设置连接点样式
        
        //设置线段样式
        context?.setLineDash(phase: 0, lengths: [18,9])
        
        //设置阴影
        /**
         * offset: 偏移量
         * blur: 模糊度
         * color: 阴影颜色
         */
        context?.setShadow(offset: CGSize(width: 4, height: 4), blur: 0.8, color: UIColor.gray.cgColor)
        
        //最后绘制图片到指定图形上下文中
        context!.drawPath(using: .fillStroke)
    }
}
