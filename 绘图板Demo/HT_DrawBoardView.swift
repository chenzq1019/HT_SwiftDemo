//
//  HT_DrawBoardView.swift
//  绘图板Demo
//
//  Created by 陈竹青 on 2020/12/25.
//

import UIKit

let kScreenWidth : CGFloat = UIScreen.main.bounds.size.width
let kScreenHeight : CGFloat = UIScreen.main.bounds.size.height
let toolHeight : CGFloat = 88
class HT_DrawBoardView: UIView {
    lazy var toolView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: toolHeight))
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    lazy var bottomView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: kScreenHeight - 80, width: kScreenWidth, height: 80))
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    lazy var boardView : HT_ScrollView = {
        let scrollView = HT_ScrollView(frame: CGRect(x: 0, y: toolHeight, width: kScreenWidth, height: kScreenHeight - toolHeight))
        scrollView.layer.backgroundColor = UIColor.white.cgColor
        scrollView.isUserInteractionEnabled = true
        scrollView.isMultipleTouchEnabled = true
        scrollView.delaysContentTouches = false
        scrollView.canCancelContentTouches = false
        return scrollView
    }()
    var drawView : HT_Drawer = {
        let view = HT_Drawer(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-toolHeight))
        return view
    }()
    let buttonImageName : [String] = ["close_draft","delete_draft","undo_draft","redo_draft"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HT_DrawBoardView{
    fileprivate func loadUI() ->Void{
        addSubview(self.toolView)
        addSubview(self.boardView)
        addSubview(self.bottomView)
        self.boardView.addSubview(self.drawView)
        self.boardView.contentSize = self.drawView.frame.size
        layoutToolView()
    }
    
    fileprivate func layoutToolView() ->Void{
        let btnw = kScreenWidth / 4.0
        let btnH = CGFloat(40)
        
        for i in 0...3 {
            let btn = UIButton(frame: CGRect(x: CGFloat(i) * btnw , y: 44, width: btnw, height: btnH))
            btn.setImage(UIImage(named: buttonImageName[i]), for: .normal)
            btn.addTarget(self, action: #selector(self.btnClick), for: .touchUpInside)
            btn.tag = i + 100
            toolView.addSubview(btn)
        }
        for i in 0...3 {
            let btn = UIButton(frame: CGRect(x: CGFloat(i) * btnw , y: 0, width: btnw, height: btnH))
            btn.setImage(UIImage(named: buttonImageName[i]), for: .normal)
            btn.addTarget(self, action: #selector(self.btnClick), for: .touchUpInside)
            btn.tag = i + 200
            bottomView.addSubview(btn)
        }
        
    }
}

extension HT_DrawBoardView {
    @objc func btnClick(sender: UIButton) ->Void{
        switch sender.tag {
        case 100:
            print("关闭")
        case 101:
            print("删除")
            drawView.cleanScreen()
        case 102:
            print("撤销")
            drawView.undo()
        case 103:
            print("回退")
            drawView.redo()
        case 200:
            drawView.chooseNorml(width: 10)
            drawView.chooseColor(color: UIColor.yellow)
        case 201:
            drawView.chooseNorml(width: 20)
            drawView.chooseColor(color: UIColor.systemPink)
        case 202:
            drawView.erase()
        default:
            print("")
        }
    }
}
