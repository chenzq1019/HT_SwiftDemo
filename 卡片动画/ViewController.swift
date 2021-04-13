//
//  ViewController.swift
//  卡片动画
//
//  Created by 陈竹青 on 2021/1/12.
//

import UIKit

let screenWidth : CGFloat = UIScreen.main.bounds.width
let screenHeight : CGFloat = UIScreen.main.bounds.height

class ViewController: UIViewController {
    
//    var dataArray : [String] = ["卡片滑动动画","翻页动画"]
    
    var dataArray : [[String]] = [["基础动画","关键帧动画","过渡动画Transition","组动画","反射变换","综合动画"],["渐变色","CAShapeLayer","加载动画"]]
    

    lazy var mTableView : UITableView = { [unowned self] in
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .grouped)
        view.dataSource = self
        view.delegate = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(self.mTableView)
    }


}


extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cells = dataArray[section]
        return cells.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let datas = dataArray[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = datas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(HTBaseAnimationVC(), animated: true)
            case 1:
                self.navigationController?.pushViewController(HTKeyframeAnimationVC(), animated: true)
            case 2:
                self.navigationController?.pushViewController(HTTransitionAnimationVC(), animated: true)
            case 3:
                self.navigationController?.pushViewController(HTGroupAnimationVC(), animated: true)
            default:
                return
            }
        }
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(HTGradientLayerVC(), animated: true)
            case 1:
                self.navigationController?.pushViewController(HTShapeLayerVC(), animated: true)
            case 2:
                self.navigationController?.pushViewController(HTLoadingVC(), animated: true)
            default:
                return
            }
        }
//        if indexPath.row == 0 {
//            self.navigationController?.pushViewController(HTCardViewController(), animated: true)
//        }
//        if indexPath.row == 1 {
//            self.navigationController?.pushViewController(HTPageAnimalVC(), animated: true)
//        }
        
    }
}
