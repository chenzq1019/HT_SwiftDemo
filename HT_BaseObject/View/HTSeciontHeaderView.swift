//
//  HTSeciontHeaderView.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/27.
//

import UIKit

class HTSeciontHeaderView: UITableViewHeaderFooterView,HTHeaderFooterViewProtocol {
    
    var myTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .blue
        return label
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(self.myTitleLabel)
        self.myTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(20)
            make.height.equalTo(40)
        }
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setModel(model: HTHeaderFooterModelProtocol) {
        let str : HTHeaderFooterBaseModel = model as! HTHeaderFooterBaseModel
        self.myTitleLabel.text = str.data as? String
    }
    
    func heightForHeaderFooterView(model: HTHeaderFooterModelProtocol, reuserIndeitfer: String, section: Int) -> CGFloat {
        return 150
    }

}
