//
//  ViewController.swift
//  HT_SwiftDemo
//
//  Created by 陈竹青 on 2020/12/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController{
    let dataSource = ["数组布局", "数组布局2", "等间距布局", "等大小布局", "九宫格", "九宫格2","系统自带布局"]
    lazy var mTableView: UITableView = { [unowned self] in
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self;
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
//        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.mTableView.contentInsetAdjustmentBehavior = .always
        let str = "Hello welcome to swfit world!"
        print(str)
//        self.edgesForExtendedLayout = [.bottom,.left,.right]
//        self.automaticallyAdjustsScrollViewInsets = false;
        view.addSubview(mTableView)
        mTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
//        var arr: Array<UIView> = [];
//        for _ in 0..<9 {
//            let subview = UIView()
//            subview.backgroundColor = UIColor.red
//            view.addSubview(subview)
//            arr.append(subview)
//        }
//
////        固定大小,可变中间间距,上下左右间距默认为0,可以设置
//        arr.snp.distributeSudokuViews(fixedItemWidth: 100, fixedItemHeight: 100, warpCount: 3)
        
//        //        固定间距,可变大小,上下左右间距默认为0,可以设置
//                arr.snp.distributeSudokuViews(fixedLineSpacing: 10, fixedInteritemSpacing: 10, warpCount: 3)
        
        
//        //        axisType:方向
//        //        fixedItemLength:item对应方向的宽或者高
//        //        leadSpacing:左边距(上边距)
//        //        tailSpacing:右边距(下边距)
//        arr.snp.distributeViewsAlong(axisType: .vertical, fixedItemLength: 100, leadSpacing: 30, tailSpacing: 30)
//        //        上面的可以约束y+h,还需要另外约束x+w
//        //        约束y和height()如果方向是纵向,那么则另外需要设置y+h
//        arr.snp.makeConstraints{
//            $0.width.left.equalTo(100)
//        }
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.backgroundColor = UIColor.random

        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var vc:UIViewController = UIViewController()
        switch indexPath.row {
        case 0:
            vc = SnapWithArrayViewController()
        case 1:
            vc = SnapWithArray2ViewController()
        case 2:
            vc = SnapSameSpaceViewController()
        case 3:
            vc = SnapSameWidthViewController()
        case 4:
            vc = SnapSudokuViewController()
        case 5:
            vc = SnapSudoku2ViewController()
        case 6:
            vc = SystemLayoutViewController()
        default: break
        }
        vc.title = dataSource[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

