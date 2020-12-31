//
//  ViewController.swift
//  CoreGraphicDemo
//
//  Created by 陈竹青 on 2020/12/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let cgView = TestDraw1(frame:CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: 100) )
          cgView.backgroundColor = UIColor.white
        self.view.addSubview(cgView)
        
        let cg2View = TestDraw2(frame: CGRect(x: 0, y: cgView.frame.maxY + 10, width: UIScreen.main.bounds.width, height: 100))
        cg2View.backgroundColor = UIColor.white
        view.addSubview(cg2View)
        
        let cg3View = TestDraw3(frame: CGRect(x: 0, y: cg2View.frame.maxY+10, width: UIScreen.main.bounds.width, height: 320))
        view.addSubview(cg3View)
        
        
        let imageView = UIImageView(frame: CGRect(x: 10, y: cg3View.frame.maxY + 10, width: 300, height: 200))
        imageView.image = drawImageAtImageContext()
        view.addSubview(imageView)
    }
    
    
    func drawImageAtImageContext() -> UIImage? {
        let size = CGSize(width: 300, height: 200)
        //获取图文上下文
        UIGraphicsBeginImageContext(size)
        let img = UIImage(named: "美女.jpeg")
        img?.draw(in: CGRect(x: 0, y: 0, width: 300, height: 200))
        
        //添加水印
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x:200,y:178))
        context?.addLine(to: CGPoint(x: 265, y: 178))
        
        UIColor.red.setStroke()
        context?.setLineWidth(2)
        context?.drawPath(using: .stroke)
        
        let str = "CHENZQ"
   
        (str as NSString).draw(in: CGRect(x: 200, y: 158, width: 100, height: 30), withAttributes: [NSAttributedString.Key.font :UIFont.boldSystemFont(ofSize: 18),NSAttributedString.Key.foregroundColor :UIColor.red])
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        
    
        return newImage
    }


}

