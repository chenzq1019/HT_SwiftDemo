//
//  TestPhoteListViewController.swift
//  CollectionViewDemo
//
//  Created by 陈竹青 on 2022/2/17.
//

import UIKit

class TestPhoteListViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        
        let layout = HTPhotoLayout()
        let screenWidth = UIScreen.main.bounds.width
        let threePiecesWidth = floor(screenWidth / 3.0 - ((2.0 / 3) * 2))
        layout.itemSize = CGSize(width: threePiecesWidth, height: threePiecesWidth)
        layout.minimumLineSpacing = 2.0
        layout.minimumInteritemSpacing = 2.0
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(HTImageCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    var  sectionOneData: [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        for index in 0..<18 {
            let name = "Sample\(index).jpg"
            let image = UIImage(named: name)
            sectionOneData.append(image!)
        }
        self.collectionView.reloadData()
    }
    

}

extension TestPhoteListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sectionOneData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HTImageCell
  
        cell.imageView.image = sectionOneData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
