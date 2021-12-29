//
//  HTCollectionHeaderView.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/29.
//

import UIKit

class HTCollectionHeaderView: UICollectionReusableView, HTHeaderFooterViewProtocol{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model: HTHeaderFooterModelProtocol) {
        
    }
    
    func sizeForheaderFooterView(modle: HTHeaderFooterModelProtocol, reuserIdentifer: String, section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
    
}
