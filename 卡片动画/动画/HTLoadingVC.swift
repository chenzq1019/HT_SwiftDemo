//
//  HTLoadingVC.swift
//  卡片动画
//
//  Created by 陈竹青 on 2021/4/2.
//

import UIKit

class PayingAnimationView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        replicatorLayer.anchorPoint = CGPoint(x: 0, y: 0)
        self.layer.addSublayer(replicatorLayer)
        
        let rectangle = CALayer()
        let width = (frame.width - 30)/5
        rectangle.bounds = CGRect(x: 0, y: 0, width: width, height: frame.height-10)
        rectangle.anchorPoint = CGPoint(x: 0, y: 0)
        rectangle.position = CGPoint(x: frame.origin.x
                                        + 10, y: frame.origin.y )
        rectangle.cornerRadius = 2
        rectangle.backgroundColor = UIColor.blue.cgColor
        replicatorLayer.addSublayer(rectangle)
        
        let animaition = CABasicAnimation(keyPath: "position.y")
        animaition.toValue = rectangle.position.y - 70
        animaition.duration = 0.7
        animaition.autoreverses = true
        animaition.repeatCount = MAXFLOAT
        rectangle.add(animaition, forKey: nil)
        
        //重复
        replicatorLayer.instanceCount = 4
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(width + 10, 0, 0)
        replicatorLayer.masksToBounds = true
        replicatorLayer.instanceDelay = 0.3
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class LoadingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        replicatorLayer.position = CGPoint(x: frame.width/2, y: frame.height/2)
        self.layer.addSublayer(replicatorLayer)
        
        let cycle = CALayer()
        cycle.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
        cycle.position = CGPoint(x: frame.width/2, y: frame.height/2 - 55)
        cycle.cornerRadius = 15/2
        cycle.backgroundColor = UIColor.white.cgColor
        replicatorLayer.addSublayer(cycle)
        
        //重复15个相同的layer
        replicatorLayer.instanceCount = 15
        let angle = CGFloat((Double.pi * 2) / 15)
        //旋转排列
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        replicatorLayer.instanceDelay = 1.0/15
        
        //添加一个缩放
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 1
        scale.toValue = 0.1
        scale.duration = 1
        scale.repeatCount = MAXFLOAT
        cycle.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)
        cycle.add(scale, forKey: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HTLoadingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow

        // Do any additional setup after loading the view.
        let repeatView = PayingAnimationView(frame: CGRect(x: 10, y: 100, width: 100, height: 100))
        self.view.addSubview(repeatView)
        
        let cycle = LoadingView(frame: CGRect(x: 10, y: 300, width: 100, height: 100))
        self.view.addSubview(cycle)
    }
}
