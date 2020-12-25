//
//  ViewController.swift
//  绘图板Demo
//
//  Created by 陈竹青 on 2020/12/25.
//

import UIKit

class ViewController: UIViewController {
    
    var drawBoard : HT_DrawBoardView = {
        let board = HT_DrawBoardView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        return board
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(drawBoard)
    }


}

