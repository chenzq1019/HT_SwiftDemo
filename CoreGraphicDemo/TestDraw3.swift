//
//  TestDraw3.swift
//  CoreGraphicDemo
//
//  Created by 陈竹青 on 2020/12/25.
//

import UIKit

class TestDraw3: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        //获取上下文
        let context = UIGraphicsGetCurrentContext()!
        drawRectWithContext(context: context)
        drawEllipse(context: context)
        drawArcView(context: context)
        drawTextStr(context: context)
        drawImage(context: context)
    }
}

extension TestDraw3{
    //画矩形
    func drawRectWithContext(context: CGContext) -> Void {
        context.addRect(CGRect(x: 10, y: 0, width: 200, height: 50))
        UIColor.red.setFill()
        context.drawPath(using: .fill)
        
        context.addRect(CGRect(x: 10, y: 60, width: 200, height: 50))
        UIColor.blue.setStroke()
        context.drawPath(using: .stroke)
    }
    //画椭圆
    func drawEllipse(context: CGContext) -> Void {
        context.addEllipse(in: CGRect(x: 10, y: 120, width: 200, height: 50))
        UIColor.systemPink.setFill()
        context.drawPath(using: .fill)
    }
    //画弧线
    func drawArcView(context: CGContext) -> Void {
        context.addArc(center: CGPoint(x: 100, y: 250), radius: 50, startAngle: 0, endAngle: CGFloat(Double.pi / 2 ), clockwise: true)
        UIColor.green.setFill()
        context.closePath()
        context.drawPath(using: .fillStroke)
    }
    //画文字
    func drawTextStr(context: CGContext) -> Void {
        let str  = "这个位置是通过Draw 函数画上去的"
        (str as NSString).draw(with: CGRect(x: 10, y: 300, width: 300, height: 20), options: .usesLineFragmentOrigin, attributes: nil, context: nil)
        
    }
    //画图片
    func drawImage(context: CGContext) -> Void {
        let image = UIImage(named: "美女.jpeg")
        context.translateBy(x: 50, y: 0)
        context.rotate(by: CGFloat(Double.pi / 16))
        image?.draw(in: CGRect(x: 200, y: 200, width: 100, height: 100))
        
    }
}
