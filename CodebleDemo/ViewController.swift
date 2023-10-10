//
//  ViewController.swift
//  CodebleDemo
//
//  Created by 陈竹青 on 2023/7/4.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let data = hotBoxJson.data(using: .utf8)
        if let data1 = data {
            do{
                let hotBox = try JSONDecoder().decode(HotBox.self, from: data1)
                print(hotBox)
            } catch {
                print(error)
            }
        }
        
    }


}

