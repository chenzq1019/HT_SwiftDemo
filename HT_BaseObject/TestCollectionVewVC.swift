//
//  TestCollectionVewVC.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/29.
//

import UIKit

class TestCollectionVewVC: UIViewController {

    lazy var collectionView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        var section : SectionBaseModel = SectionBaseModel()
        section.header = HTHeaderFooterBaseModel(viewClass: HTCollectionHeaderView.self, data: "精品特卖")
        section.minimuLineSpacing = 10
        section.minimuInteritemSpaceing = 10
        section.inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        for index in 0..<10 {
            let cellModel = HTCellBaseModel(cellClass: MyCollectionViewCellOne.self,data: "这是数据\(index)==")
            section.cellArray?.append(cellModel)
        }
        var sectionOne : SectionBaseModel = SectionBaseModel()
        sectionOne.header = HTHeaderFooterBaseModel(viewClass: HTCollectionHeaderView.self, data: "热门推荐")
        sectionOne.minimuLineSpacing = 10
        sectionOne.minimuInteritemSpaceing =  10
        sectionOne.inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        for index in 0..<12 {
            let cellModel =  HTCellBaseModel(cellClass: MyCollectionViewCellTwo.self,data: "第二个组的数据 \(index) ==")
            sectionOne.cellArray?.append(cellModel)
        }
        self.collectionView.mDataArray = [section, sectionOne]
        self.collectionView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
