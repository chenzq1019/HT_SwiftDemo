//
//  GallerisViewController.swift
//  自定义转场动画
//
//  Created by 陈竹青 on 2021/3/29.
//

import UIKit
import SnapKit

class GallerisViewController: UIViewController {
    
    lazy var layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width : CGFloat = (UIScreen.main.bounds.width - 40) / 3
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    lazy var myCollection : UICollectionView = { [unowned self] in
        var collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        collection.backgroundColor = .white
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        loadUI()
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

extension GallerisViewController{
    func loadUI() -> Void {
        self.view.addSubview(self.myCollection)
        self.myCollection.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}

extension GallerisViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(AlbumViewController(), animated: true)
        
    }
}
