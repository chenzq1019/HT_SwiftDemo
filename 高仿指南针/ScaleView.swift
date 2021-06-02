//
//  ScaleView.swift
//  高仿指南针
//
//  Created by 陈竹青 on 2021/4/15.
//

import UIKit

class ScaleView: UIView {
    lazy var backgroudView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);

        self.addSubview(self.backgroudView)
        paintingScale()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func paintingScale() -> Void {
        let perAngel  = Double.pi/90 //获取2度对应的值
        let arry = ["北","东","南","西"]
        for i in 0..<180 {
            let startAngle = perAngel * Double(i) - (Double.pi/2+Double.pi/360)
            let endAngle = startAngle + perAngel/2
            let bezPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2), radius: self.frame.width/2 - 50, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
            let shapeLayer = CAShapeLayer()
            //每隔30度画一条白线
            if i%15 == 0 {
                shapeLayer.strokeColor = UIColor.white.cgColor
                shapeLayer.lineWidth = 20
            }else{
                shapeLayer.strokeColor = UIColor.gray.cgColor
                shapeLayer.lineWidth = 10
            }
            shapeLayer.path = bezPath.cgPath
            shapeLayer.fillColor = UIColor.clear.cgColor
            self.backgroudView.layer.addSublayer(shapeLayer)
            
            //标注刻度
            if i%15 == 0 {
                let kedu = "\(i*2)"
                let textangle =  startAngle+(endAngle-startAngle)/2
                let point = self.caculateTextPosition(angle: textangle, width: self.frame.width/2 - 50,scale: 1.2)
                let lable = UILabel(frame: CGRect(x: point.x, y: point.y, width: 30, height: 15))
                lable.center = point
                lable.text = kedu
                lable.textColor = .white
                lable.font = UIFont.systemFont(ofSize: 15)
                lable.textAlignment = .center
                self.backgroudView.addSubview(lable)
            }
            if i%45 == 0 {
                let str = arry[i/45]
                let point = self.caculateTextPosition(angle: endAngle, width: self.frame.width/2 - 50,scale: 0.8)
                let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
                lable.center = point
                lable.font = UIFont.systemFont(ofSize: 20)
                lable.textColor = .white
                lable.textAlignment = .center
                lable.text = str
                self.backgroudView.addSubview(lable)
            }
            
        }
        
        let leveView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width/4, height: 1))
        leveView.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        leveView.backgroundColor = .white
        self.addSubview(leveView)
        
        let verticalView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: self.frame.width/4))
        verticalView.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        verticalView.backgroundColor = .white
        self.addSubview(verticalView)
        
    }
    
    func caculateTextPosition(angle:Double , width:CGFloat ,scale: CGFloat) -> CGPoint {
        let x = width * scale * CGFloat(cosf(Float(angle)))
        let y = width * scale * CGFloat(sinf(Float(angle)))
        let point = CGPoint(x: x + self.frame.width / 2, y: y + self.frame.width/2)
        return point
    }
    
    func resetDirection(heading : CGFloat) -> Void {
        UIView.animate(withDuration: 0.1) {
            self.backgroudView.transform = CGAffineTransform(rotationAngle: heading)
            
            for view in self.backgroudView.subviews {
                
                if view.isKind(of: UILabel.self) {
                    view.transform = CGAffineTransform(rotationAngle: -heading)
                }
            }
        }

 
    }

}
