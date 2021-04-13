//
//  HTShapeLayerVC.swift
//  卡片动画
//
//  Created by 陈竹青 on 2021/4/2.
//

import UIKit


class ProgressView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let shapeLayer = CAShapeLayer()
        
        let path = UIBezierPath(arcCenter: CGPoint(x: frame.width/2, y: frame.height/2), radius: frame.width/2, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0.9
        self.layer.addSublayer(shapeLayer)
        
        //添加动画
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1
        animation.duration = 4.0
        animation.repeatCount = MAXFLOAT
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        shapeLayer.add(animation, forKey: "strokAnimation")
        
        let animaiton2 = CABasicAnimation(keyPath: "transform.rotation.z")
        animaiton2.toValue = -CGFloat(Double.pi * 2)
        animaiton2.duration = 2
        animaiton2.repeatCount = MAXFLOAT
//        animaiton2.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.layer.add(animaiton2, forKey: "rotation")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HTShapeLayerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let prosess = ProgressView(frame: CGRect(x: 10, y: 100, width: 100, height: 100))
        self.view.addSubview(prosess)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
