//
//  HTPhotoLayout.swift
//  CollectionViewDemo
//
//  Created by 陈竹青 on 2022/2/17.
//

import UIKit

class HTPhotoLayout: UICollectionViewFlowLayout {
    
    var attributeAttray: [UICollectionViewLayoutAttributes]!
    
    //准备阶段
    override func prepare() {
        super.prepare()
        attributeAttray = []
        let sections : Int = collectionView!.numberOfSections
        if sections > 0 {
            for section in 0..<sections {
                let rows :Int = collectionView!.numberOfItems(inSection: section)
                for row in 0..<rows {
                    let indexpath: IndexPath = IndexPath.init(item: row, section: section)
                    let attribute = self.layoutAttributesForItem(at: indexpath)
                    print(attribute)
                    if row == 0 {
                        attribute?.frame = CGRect(x: 0, y: 0, width: attribute!.frame.width, height: attribute!.frame.height)
                    }
                    if row == 1 {
                        attribute?.frame = CGRect(x: 141*2+2, y: 0, width:  attribute!.frame.width, height: attribute!.frame.height)
                    }
                    
                    
                    
                    attributeAttray.append(attribute!)
                }
            }
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributeAttray
    }
    
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        let attribute = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
//        print(attribute)
//        return attribute
//    }


}
