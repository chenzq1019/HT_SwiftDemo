//
//  StackDemoVC02.swift
//  StackViewDemo
//
//  Created by 陈竹青 on 2021/3/31.
//

import UIKit

class StackDemoVC02: UIViewController {
    
    lazy var mStackView : UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .leading
        view.distribution = .equalSpacing
        view.spacing = 5
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor =  .white
        
//        let letfView = UIView()
//        letfView.backgroundColor = .red
////        letfView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
//        self.mStackView.addArrangedSubview(letfView)
//
//        let rightView = UIView()
//        rightView.backgroundColor = .blue
//        self.mStackView.addArrangedSubview(rightView)
        
        
        for _ in 0..<13 {
            let view = UIView()
            view.backgroundColor = UIColor.red
            view.snp.makeConstraints { (make) in
                make.width.equalTo(100)
                make.height.equalTo(100)
            }
        
            self.mStackView.addArrangedSubview(view)
        }
        
//        self.view.addSubview(self.mStackView)
//        self.mStackView.snp.makeConstraints { (make) in
//            make.left.top.right.equalTo(self.view)
//            make.height.equalTo(300)
//        }
        
        let  scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(300)
        }
        
        scrollView.addSubview(self.mStackView)
        self.mStackView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
        }
        

    }
}
