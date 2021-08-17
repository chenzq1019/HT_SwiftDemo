//
//  HTBaseCollectionCell.swift
//  卡片动画/Users/chenzhuqing/Desktop/GitProject/HT_SwiftDemo1/图形裁边添加圆角
//
//  Created by 陈竹青 on 2021/4/1.
//

import UIKit
import SnapKit

class HTBaseCollectionCell: UICollectionViewCell {
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
