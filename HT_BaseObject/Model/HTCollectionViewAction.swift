//
//  HTCollectionViewAction.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/28.
//

import Foundation
import UIKit

class HTCollectionViewAction: NSObject {
    var dataArray: [SectionBaseModel]?
    var reuserCellSet : Set<String>? = Set()
    var enableFlowLayoutProperties: Bool = false
}

extension HTCollectionViewAction: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section: SectionBaseModel = self.dataArray?[section] else {
            return 0
        }
        guard let array = section.cellArray else{
            return 0
        }
        return array.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let array = self.dataArray else{
            return 0
        }
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionMode : SectionBaseModel  = self.dataArray![indexPath.section]
        let cellModel : HTCellBaseModelProtocl = sectionMode.cellArray![indexPath.row]
        let cellName:String = cellModel.cellName
        if let contaner = self.reuserCellSet, contaner.contains(cellName) == false{
            self.reuserCellSet?.insert(cellName)
            collectionView.register(cellModel.cellClass, forCellWithReuseIdentifier: cellName)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath)
        if let myCell : HTCellViewProtocol = cell as? HTCellViewProtocol {
            myCell.setModel(model: cellModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionMode : SectionBaseModel  = self.dataArray![indexPath.section]
        guard let headFoot = sectionMode.header  else {
            return UICollectionReusableView()
        }
        var data: HTHeaderFooterModelProtocol?
        if kind == UICollectionView.elementKindSectionHeader {
            data = sectionMode.header
        }else if kind == UICollectionView.elementKindSectionFooter {
            data = sectionMode.footer
        }
        guard let headFootData = data else{
            return UICollectionReusableView()
        }
        let name = headFootData.viewName
        if let contaner = self.reuserCellSet, contaner.contains(name) == false{
            self.reuserCellSet?.insert(name)
            collectionView.register(headFootData.viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: name)
        }
        let headFootView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: name, for: indexPath)
        if let view : HTHeaderFooterViewProtocol = headFootView as? HTHeaderFooterViewProtocol {
            view.setModel(model: headFoot)
        }
        return headFootView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let sectionMode : SectionBaseModel  = self.dataArray![indexPath.section]
//        let cellModel : HTCellBaseModelProtocl = sectionMode.cellArray![indexPath.row]
        let cell = self.collectionView(collectionView, cellForItemAt: indexPath)
        if let temp = cell as? HTCellViewProtocol {
            temp.didSelectedAt(indexPath: indexPath)
        }
    }
   
}

extension HTCollectionViewAction: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.enableFlowLayoutProperties,let layout :UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return layout.itemSize
        }
        let sectionMode : SectionBaseModel  = self.dataArray![indexPath.section]
        guard let itemModel = sectionMode.cellArray?[indexPath.row]  else {
            return CGSize.zero
        }
        guard itemModel.itemSize == CGSize.zero else{
            return itemModel.itemSize
        }
        let itemCell =  (itemModel.cellClass as! UICollectionViewCell.Type).init()
        if let tempCell : HTCellViewProtocol = itemCell as? HTCellViewProtocol {
            return tempCell.sizeForcell(model: itemModel, reuserIdentifer: itemModel.cellName, indexPath: indexPath)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if self.enableFlowLayoutProperties,let layout :UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return layout.headerReferenceSize
        }
        let sectionMode : SectionBaseModel  = self.dataArray![section]
        guard let headModel = sectionMode.header else {
            return CGSize.zero
        }
        return sizeForHeaderFooterView(collectionView: collectionView, section: section, data: headModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.enableFlowLayoutProperties,let layout :UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return layout.footerReferenceSize
        }
        let sectionMode : SectionBaseModel  = self.dataArray![section]
        guard let footModel = sectionMode.footer else {
            return CGSize.zero
        }
        return sizeForHeaderFooterView(collectionView: collectionView, section: section, data: footModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if self.enableFlowLayoutProperties,let layout :UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return layout.minimumLineSpacing
        }
        let sectionMode : SectionBaseModel  = self.dataArray![section]
        return sectionMode.minimuLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if self.enableFlowLayoutProperties,let layout :UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return layout.minimumInteritemSpacing
        }
        let sectionMode : SectionBaseModel  = self.dataArray![section]
        return sectionMode.minimuInteritemSpaceing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if self.enableFlowLayoutProperties,let layout :UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return layout.sectionInset
        }
        let sectionMode : SectionBaseModel  = self.dataArray![section]
        return sectionMode.inset
    }
    
  private  func sizeForHeaderFooterView(collectionView:UICollectionView, section:Int ,data: HTHeaderFooterModelProtocol) -> CGSize {
      if let size = data.itemSize, size != CGSize.zero {
          return size
      }
      let view = (data.viewClass as! UICollectionReusableView.Type).init()
      if let headFootView: HTHeaderFooterViewProtocol = view as? HTHeaderFooterViewProtocol {
          return headFootView.sizeForheaderFooterView(modle: data, reuserIdentifer: data.viewName, section: section)
      }
      return CGSize.zero
    }
}
