//
//  HTTableViewAction.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/24.
//

import Foundation
import UIKit

class HTTableViewAction: NSObject {
    var dataArray: [SectionBaseModel]?
}

extension HTTableViewAction: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let array = self.dataArray else{
            return 0
        }
        let sectionMode : SectionBaseModel  = array[section]
        return sectionMode.cellArray?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionMode : SectionBaseModel  = self.dataArray![indexPath.section]
        let cellModel : HTCellBaseModelProtocl = sectionMode.cellArray![indexPath.row]
        let cellName = cellModel.cellName 
        var cell = tableView.dequeueReusableCell(withIdentifier: cellName) 
        if cell == nil {
            cell = (cellModel.cellClass as! UITableViewCell.Type).init(style: .default, reuseIdentifier: cellName)
        }
        if let myCell : HTCellViewProtocol = cell as? HTCellViewProtocol {
            myCell.setModel(model: cellModel)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionMode : SectionBaseModel  = self.dataArray![indexPath.section]
        let cellModel : HTCellBaseModelProtocl = sectionMode.cellArray![indexPath.row]
        let cellName =  cellModel.cellName
        let cell = (cellModel.cellClass as! UITableViewCell.Type).init(style: .default, reuseIdentifier: cellName)
        if let tempCell : HTCellViewProtocol = cell as? HTCellViewProtocol {
            let height : CGFloat = tempCell.heightForCell(model: cellModel, reuserIdentifer: cellName, indexPatch: indexPath)
            return height == 0 ? UITableView.automaticDimension : height
        }
        return UITableView.automaticDimension;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView(tableView, cellForRowAt: indexPath)
        if let myCell: HTCellViewProtocol = cell as? HTCellViewProtocol {
            myCell.didSelectedAt(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionMode : SectionBaseModel  = self.dataArray![section]
        guard let headModel = sectionMode.header else {
            return nil
        }
        return buildHeaderOrFooterView(tableView: tableView, data: headModel)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionMode : SectionBaseModel  = self.dataArray![section]
        guard let footModel = sectionMode.footer else {
            return nil
        }
        return buildHeaderOrFooterView(tableView: tableView, data: footModel)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel : SectionBaseModel  = self.dataArray![section]
        guard let headModel = sectionModel.header else {
            return 0.0001
        }
        return getHeaderOrFooterViewHeight(tableView: tableView, data: headModel, section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionModel : SectionBaseModel  = self.dataArray![section]
        guard let footModel = sectionModel.footer else {
            return 0.0001
        }
        return getHeaderOrFooterViewHeight(tableView: tableView, data: footModel, section: section)
    }
    
    private func buildHeaderOrFooterView(tableView: UITableView, data: HTHeaderFooterModelProtocol?) -> UITableViewHeaderFooterView? {
        var headView = tableView.dequeueReusableHeaderFooterView(withIdentifier: data!.viewName)
        if headView == nil {
            headView = (data!.viewClass as! UITableViewHeaderFooterView.Type).init(reuseIdentifier: data!.viewName)
        }
        if let header: HTHeaderFooterViewProtocol = headView as? HTHeaderFooterViewProtocol {
            header.setModel(model: data!)
        }
        return headView
    }
    
    private func getHeaderOrFooterViewHeight(tableView: UITableView, data: HTHeaderFooterModelProtocol,section:Int) -> CGFloat {
        var headView = tableView.dequeueReusableHeaderFooterView(withIdentifier: data.viewName)
        if headView == nil {
            headView = (data.viewClass as! UITableViewHeaderFooterView.Type).init(reuseIdentifier: data.viewName)
        }
        if let header : HTHeaderFooterViewProtocol = headView as? HTHeaderFooterViewProtocol {
            return header.heightForHeaderFooterView(model: data, reuserIndeitfer: data.viewName, section: section)
        }
        return 0.0001
    }
    
}
