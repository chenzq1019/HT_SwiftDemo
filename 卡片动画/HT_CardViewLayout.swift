//
//  HT_CardViewLayout.swift
//  卡片动画
//
//  Created by 陈竹青 on 2021/1/12.
//

import UIKit

class HT_CardViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 10
        self.sectionInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        self.itemSize = CGSize(width: self.collectionView!.frame.size.width - 80, height: self.collectionView!.frame.size.height - 40)
        super.prepare()
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let superAttribute = super.layoutAttributesForElements(in: rect)
//        let attributes = superAttribute
//        guard let tempView = self.collectionView else {
//            return attributes
//        }
//        let visibleRect = CGRect(x: tempView.contentOffset.x, y: tempView.contentOffset.y, width: tempView.frame.size.width, height: tempView.frame.size.height)
//        let offset = visibleRect.midX
//
//        if let visibleAttribute = attributes {
//            visibleAttribute.map {(attribute : UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes in
//                let distance = offset - attribute.center.x
//                let scaforDistance = distance / (self.itemSize.width + self.minimumLineSpacing)
//                let sacelForCell = CGFloat(1.02 - 0.1 * fabs(Double(scaforDistance)))
//                attribute.transform3D = CATransform3DMakeScale(sacelForCell, sacelForCell, 1)
//                attribute.zIndex = 1
//                return attribute
//            }
//            return visibleAttribute
//        }
//        return  nil
        
        let array = super.layoutAttributesForElements(in: rect)
        let centerX = self.collectionView!.contentOffset.x + self.collectionView!.frame.width/2.0
        
        guard let targetArray = array else {
            return nil
        }
        
        for attri in targetArray {
            let delta = abs(attri.center.x - centerX)
            let scaforDistance = delta / (self.itemSize.width + self.minimumLineSpacing)
            let scale = CGFloat(1.02 - 0.1 * fabs(Double(scaforDistance)))
            attri.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        return targetArray
        
    }
    //停止滑动，吸附在指定位置
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offsetAdjustment :CGFloat = CGFloat(MAXFLOAT)
        let horizontalCenter = proposedContentOffset.x + self.collectionView!.bounds.width / 2.0
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: self.collectionView!.bounds.size.width, height: self.collectionView!.bounds.size.height)
        let array = super.layoutAttributesForElements(in: targetRect)
        //找出最近的一个item，
        if let targetArray = array {
            for arttribute in targetArray {
                let itemHorizonCenter = arttribute.center.x
                if abs(CGFloat(itemHorizonCenter - horizontalCenter)) < abs(CGFloat(offsetAdjustment)) {
                    offsetAdjustment = CGFloat(itemHorizonCenter - horizontalCenter)
                }
            }
        }
        //返回最近的
        return CGPoint(x: proposedContentOffset.x + CGFloat(offsetAdjustment), y: proposedContentOffset.y)
    }

}


