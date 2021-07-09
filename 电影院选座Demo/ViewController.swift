//
//  ViewController.swift
//  电影院选座Demo
//
//  Created by 陈竹青 on 2021/7/8.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchAction(_ sender: Any) {
        self.navigationController?.pushViewController(MoveSelectController(), animated: true)
    }
    
}

