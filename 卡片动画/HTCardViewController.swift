//
//  HTCardViewController.swift
//  卡片动画
//
//  Created by 陈竹青 on 2021/3/30.
//

import UIKit

class HTCardViewController: UIViewController {
    lazy var layout : HT_CardViewLayout = {
        let layout = HT_CardViewLayout()
        return layout
    }()
    lazy var mCollectionView : UICollectionView = {
        let view = UICollectionView(frame: CGRect(x: 0, y: 60, width: screenWidth, height: screenWidth - 60), collectionViewLayout: self.layout)
        view.dataSource = self
        view.delegate = self
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        view.backgroundColor = .white
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.view.addSubview(self.mCollectionView)
    }
}

extension HTCardViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = UIColor.randomColor
        return cell
    }
}


extension UIColor {
    class var randomColor : UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
