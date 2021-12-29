//
//  HTFirstTableViewCell.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/24.
//

import UIKit
import SnapKit

class HTFirstTableViewCell: UITableViewCell,HTCellViewProtocol{
    var model: HTCellBaseModel?
    var picImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    var subView : UIView = {
        let view =  UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    func didSelectedAt(indexPath: IndexPath) {
        print(self.model?.data as Any)
    }
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(self.picImage)
        picImage.snp.makeConstraints { make in
            make.left.top.equalTo(self.contentView)
            make.size.equalTo(CGSize(width: 100, height: 150))
        }
        contentView.addSubview(self.subView)
        self.subView.snp.makeConstraints { make in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.picImage.snp.bottom)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualTo(self.contentView.snp.bottom)
        }
    }
    
    func setModel(model: HTCellBaseModelProtocl) {
        self.model = model as? HTCellBaseModel
        self.textLabel?.text = self.model?.data as? String
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func heightForCell(model: HTCellBaseModelProtocl, reuserIdentifer: String, indexPatch: IndexPath) -> CGFloat {
//        return 300
//    }
    
}
