//
//  HTGradientLayerVC.swift
//  卡片动画
//
//  Created by 陈竹青 on 2021/4/2.
//

import UIKit

class HTGradientLayerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .gray
        
        self.loadGradientLayerView()
    }
    
    func loadGradientLayerView() -> Void {
        let textlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        textlabel.center = self.view.center
        textlabel.textColor = UIColor(white: 1, alpha: 0.8)
        textlabel.textAlignment = .center
        textlabel.text = ">>> 滑动来解锁 >>>"
        self.view.addSubview(textlabel)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = textlabel.bounds
        let startColor = UIColor.black
        let endColor = UIColor.clear
        gradientLayer.colors = [endColor.cgColor, startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0 )
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.locations = [0.2,0.5,0.8]
        
        textlabel.layer.mask = gradientLayer
        
        
        //添加动画
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0,0,0.25]
        animation.toValue = [0.75,1,1]
        animation.repeatCount = MAXFLOAT
        animation.duration = 2.5
        gradientLayer.add(animation, forKey: "animation")
    }


}
