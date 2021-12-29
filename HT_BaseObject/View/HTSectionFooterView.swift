//
//  HTSectionFooterView.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/28.
//

import UIKit

class HTSectionFooterView: UITableViewHeaderFooterView,HTHeaderFooterViewProtocol {

    var footModel: Any?
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model: HTHeaderFooterModelProtocol) {
        self.footModel = model
        
    }
    
    func heightForHeaderFooterView(model: HTHeaderFooterModelProtocol, reuserIndeitfer: String, section: Int) -> CGFloat {
        return 50
    }
}
