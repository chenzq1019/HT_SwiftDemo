//
//  MyCollectionViewCellOne.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/29.
//

import UIKit

class MyCollectionViewCellOne: UICollectionViewCell,HTCellViewProtocol {
    var model: HTCellBaseModelProtocl?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model: HTCellBaseModelProtocl) {
        self.model = model
    }
    
    func sizeForcell(model: HTCellBaseModelProtocl, reuserIdentifer: String, indexPath: IndexPath) -> CGSize {
        
        let width : CGFloat =  (UIScreen.main.bounds.size.width - 30) / 2.0
        
        return CGSize(width: width, height: 150)
    }
    
    func didSelectedAt(indexPath: IndexPath) {
        print("点击了 secion = \(indexPath.section)  row = \(indexPath.row)")
        print(self.model?.data)
    }
}

class MyCollectionViewCellTwo: UICollectionViewCell, HTCellViewProtocol {
    var model: HTCellBaseModelProtocl?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model: HTCellBaseModelProtocl) {
        self.model = model
    }
    
    func sizeForcell(model: HTCellBaseModelProtocl, reuserIdentifer: String, indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.size.width - 20 - 10 * 2) / 3.0
        return CGSize(width: width, height: 200)
    }
    
    func didSelectedAt(indexPath: IndexPath) {
        print("点击了 secion = \(indexPath.section)  row = \(indexPath.row)")
        print(self.model?.data)
    }
}
