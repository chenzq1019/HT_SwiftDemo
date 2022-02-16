//
//  ViewController.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var action : HTTableViewAction = {
        let action = HTTableViewAction()
        return action
    }()
    
    lazy var tableView: UITableView = { [unowned self] in
        let view = UITableView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: .grouped)
//        view.dataSource = self.action
//        view.delegate = self.action
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        // Do any additional setup after loading the view.
        var sectionModel = SectionBaseModel()
        sectionModel.header = HTHeaderFooterBaseModel(viewClass: HTSeciontHeaderView.self ,data: "热门商品")
        sectionModel.footer = HTHeaderFooterBaseModel(viewClass: HTSectionFooterView.self, data: "我是底部")
        var cellArray: [HTCellBaseModelProtocl] = []
        for index in 0..<10 {
            let cellModel = HTCellBaseModel(cellClass: HTFirstTableViewCell.self,data:  "这是数据\(index)")
            sectionModel.cellArray?.append(cellModel)
            cellArray.append(cellModel)
        }
//        tableView.cellArray = cellArray
        tableView.mDataArray = [sectionModel]
        tableView.reloadData()
    }


}

