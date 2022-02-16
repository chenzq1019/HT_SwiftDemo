//
//  HTCollectionHeaderView.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/29.
//

import UIKit

class HTCollectionHeaderView: UICollectionReusableView, HTHeaderFooterViewProtocol{
    lazy var titlLabel: UILabel  = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    var model: HTHeaderFooterModelProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        self.addSubview(self.titlLabel)
        self.titlLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(20)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model: HTHeaderFooterModelProtocol) {
        self.model = model
        if let str = model.data as? String {
            self.titlLabel.text = str
        }
    }
    
    func sizeForheaderFooterView(modle: HTHeaderFooterModelProtocol, reuserIdentifer: String, section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
    
}
