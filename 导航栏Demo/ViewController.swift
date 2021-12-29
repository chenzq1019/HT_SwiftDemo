//
//  ViewController.swift
//  导航栏Demo
//
//  Created by 陈竹青 on 2021/10/8.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .red
        
        let leftItem : UIBarButtonItem = UIBarButtonItem(title: "左边", style: .plain, target: self, action: #selector(leftClick))
        
       
        self.navigationItem.leftBarButtonItem = leftItem
        
//        self.navBarBgAlpha = 0.0
        
  
    
        
    }
    
    @objc func leftClick(){
        print("left click")
    }


}

