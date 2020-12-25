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
        self.view.addSubview(maksView)
    }


}

