//
//  MyTestItemCell.swift
//  UICollection布局切换
//
//  Created by 陈竹青 on 2023/6/20.
//

import UIKit

class MyTestItemCell: UICollectionViewCell {
    var model: TestModel?
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var subLabel: UILabel = {
        let sub = UILabel()
        sub.backgroundColor = .green
        sub.translatesAutoresizingMaskIntoConstraints = false
        return sub
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(subLabel)
        layoutGridView()
    }
    fileprivate func relayoutCell(_ model: TestModel) {
//        if(model.layouType == .list){
//            layoutListView()
//
//        }
//        else{
//            layoutGridView()
//        }
    }

    
    fileprivate func layoutListView() {
        
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
        
        
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        subLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10).isActive = true
        subLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        subLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        subLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        setNeedsUpdateConstraints()
        layoutIfNeeded()
    }
    fileprivate func layoutGridView(){
        
      
        
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        subLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10).isActive = true
        subLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        subLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        subLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        
        setNeedsUpdateConstraints()
        layoutIfNeeded()
    }
    
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        guard let model = model else {return}
        relayoutCell(model)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
