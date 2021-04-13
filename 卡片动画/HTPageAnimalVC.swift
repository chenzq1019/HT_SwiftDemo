//
//  HTPageAnimalVC.swift
//  卡片动画
//
//  Created by 陈竹青 on 2021/3/30.
//

import UIKit

struct OptionTest : OptionSet {
    public var rawValue: UInt8

    static let Sunday = OptionTest(rawValue: 1 << 0)

    static let Monday = OptionTest(rawValue: 1 << 1)

    static let Tuesday = OptionTest(rawValue: 1 << 2)

    static let Wednesday = OptionTest(rawValue: 1 << 3)

    static let Thursday = OptionTest(rawValue: 1 << 4)

    static let Friday = OptionTest(rawValue: 1 << 5)

    static let Saturday = OptionTest(rawValue: 1 << 6)
}

class HTPageAnimalVC: UIViewController {
    
    lazy var bookTop : UIView = {
        let view = UIView(frame: CGRect(x: -100, y: 0, width: 200, height: 200))
        view.backgroundColor = .red
        view.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        return view
    }()
    
    lazy var bookView : UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 100, width: 200, height: 200))
        view.backgroundColor = .black
        view.addSubview(self.bookTop)
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClickAt))
        view.addGestureRecognizer(tap)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        loadUI()
        // Do any additional setup after loading the view.
        
        let optione : OptionTest = [.Wednesday]
        if optione.contains(.Sunday) {
            print("sunday")
        }
        if optione.contains(.Monday) {
            print("Monday")
        }
        if optione.contains(.Saturday) {
            print("Saturday")
        }
    }
}

extension HTPageAnimalVC{
    func loadUI() -> Void {
        self.view.addSubview(self.bookView)
    }
    
}

extension HTPageAnimalVC {
    @objc func tapClickAt(){
        print("tapClickAt")

//        UIView.animate(withDuration: 0.5) {
//            var transform : CATransform3D = CATransform3DIdentity
//            transform.m34 =  1.0/500.0
//            transform = CATransform3DRotate(transform, CGFloat(Double.pi/4.0), 0, 1, 0 )
//            self.bookTop.layer.transform = transform
//        }
        
//        self.opcityAniamtion()
        self.scaleAnimation()
    }
    
    func opcityAniamtion() -> Void {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 0.5
        
        self.bookTop.layer.add(animation, forKey: "image-opactiy")
    }
    
    func scaleAnimation() -> Void {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 2.0
        animation.duration = 1
        self.bookTop.layer.add(animation, forKey: "scaleAnimation")
    }
}
