//
//  CustemView.swift
//  图形裁边添加圆角
//
//  Created by 陈竹青 on 2020/12/24.
//

import UIKit

class CustemView: UIView {

    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
//        addMastLayer()
        addCustemBezierPath()
        let lable = UILabel(frame: CGRect(x: 0, y: frame.height-30, width: frame.width, height: 30))
        lable.backgroundColor = UIColor.blue
        addSubview(lable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustemView {
    //普通圆角切边
    func addMastLayer() -> Void {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 5, height: 5))
        let masklayer = CAShapeLayer()
        masklayer.frame = self.bounds
        masklayer.path = maskPath.cgPath
        self.layer.mask = masklayer
        
        
    }
    //自定义形状
    /**
     *addArc 方法中，是绘制圆形，角度最右边是0 度。然后顺时针开始计算开始结束的角度。
     *
     */
    func addCustemBezierPath() -> Void {
        let bezierPath = UIBezierPath()
        let cardRadius = CGFloat(30)
        let buttonRadius = CGFloat(20)
        let effectiveViewH = frame.height - buttonRadius
        
        bezierPath.move(to: CGPoint(x: cardRadius, y: 0))
        bezierPath.addLine(to: CGPoint(x: self.frame.width - cardRadius, y: 0))
        bezierPath.addArc(withCenter: CGPoint(x: self.frame.width - cardRadius, y: cardRadius), radius: cardRadius, startAngle: CGFloat(Double.pi * 3 / 2), endAngle: 0, clockwise: true)
        //right lint
        bezierPath.addLine(to: CGPoint(x: frame.width, y: effectiveViewH))
        //bottom - right
        bezierPath.addArc(withCenter: CGPoint(x: frame.width - cardRadius, y: effectiveViewH - cardRadius), radius: cardRadius, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: true)
        //right-half -bottomline
        bezierPath.addLine(to: CGPoint(x: frame.width / 4 * 3, y: effectiveViewH))
        //button-right
        bezierPath.addArc(withCenter: CGPoint(x: frame.width / 4 * 3 - buttonRadius , y: effectiveViewH), radius: buttonRadius, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: true)
        //bottom buttton line
        bezierPath.addLine(to: CGPoint(x: self.frame.width / 4 + buttonRadius, y: effectiveViewH + buttonRadius))
        //button - left
        bezierPath.addArc(withCenter: CGPoint(x: frame.width / 4 + buttonRadius, y: effectiveViewH), radius: buttonRadius, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi), clockwise: true)
        //bottom butn line
        bezierPath.addLine(to: CGPoint(x: cardRadius, y: effectiveViewH))
        //botton -lelf
        bezierPath.addArc(withCenter: CGPoint(x: cardRadius, y: effectiveViewH - cardRadius), radius: cardRadius, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi), clockwise: true)
        //left line
        bezierPath.addLine(to: CGPoint(x: 0, y: cardRadius))
        //top - left
        bezierPath.addArc(withCenter: CGPoint(x: cardRadius, y: cardRadius), radius: cardRadius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi * 3 / 2), clockwise: true)
        bezierPath.close()
  
        let masklayer = CAShapeLayer()
        masklayer.frame = self.bounds
        masklayer.path = bezierPath.cgPath
        self.layer.mask = masklayer
        
    }
}
