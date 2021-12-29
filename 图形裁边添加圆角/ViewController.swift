//
//  ViewController.swift
//  图形裁边添加圆角
//
//  Created by 陈竹青 on 2020/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var maksView : CustemView = {
        let view = CustemView(frame: CGRect(x: 10, y: 100, width: 300, height: 400))
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.view.addSubview(maksView)
        let str = "Hello , welcome to swift world";
        print(str)
        testDrawFunc1()
    }
    
    func testMaskLayerView() -> Void {
        view.addSubview(self.maksView)
    }
    
    func testDrawFunc1() -> Void {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        let path = CGMutablePath()
        let A = CGPoint(x: 10, y: 100)
        let B = CGPoint(x: 10, y: 200)
        let C = CGPoint(x: 100, y: 200)
        path.move(to: A)
        path.addArc(tangent1End: B, tangent2End: C, radius: 20)
        path.addLine(to: C)
        path.closeSubpath()
        shapeLayer.path = path
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        self.view.layer.addSublayer(shapeLayer)
    }


}

