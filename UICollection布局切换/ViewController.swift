//
//  ViewController.swift
//  UICollection布局切换
//
//  Created by 陈竹青 on 2023/6/20.
//

import UIKit

let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.size.width

class ViewController: UIViewController {
    private var viewModel: TestViewModel = TestViewModel()
    
    private var layouType: TestModel.LayoutType = .list
    
    private lazy var listLayout : UICollectionViewFlowLayout = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        print(SCREEN_WIDTH)
        collectionLayout.itemSize = CGSize(width: SCREEN_WIDTH, height: 80)
        collectionLayout.minimumLineSpacing = 10
        collectionLayout.minimumInteritemSpacing = 10
        collectionLayout.scrollDirection = .vertical
        return collectionLayout
    }()
    
    private lazy var gridLayout : UICollectionViewFlowLayout = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        collectionLayout.itemSize = CGSize(width: ((SCREEN_WIDTH - 80) / 2.0), height: (SCREEN_WIDTH - 180))
        collectionLayout.minimumLineSpacing = 20
        collectionLayout.minimumInteritemSpacing = 20
        return collectionLayout
    }()
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: gridLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MyTestItemCell.self, forCellWithReuseIdentifier: "myTestItem")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        view.addSubview(self.collectionView)
        self.collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(changeStyle(_ :)))
        viewModel.requestData { [unowned self] array in
            self.collectionView.reloadData()
        }
    }

    @objc func changeStyle(_ sender: UIBarButtonItem) {
        if layouType == .list {
            layouType = .grid
            viewModel.transforLayoutType(type: .grid)
            self.collectionView.setCollectionViewLayout(self.gridLayout, animated: true)
        }else{
            layouType = .list
            viewModel.transforLayoutType(type: .list)
            self.collectionView.setCollectionViewLayout(self.listLayout, animated: true)
        }
    }

}


extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let array = viewModel.items else { return 0}
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let array = viewModel.items else { return UICollectionViewCell()}
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myTestItem", for: indexPath) as! MyTestItemCell
        cell.contentView.backgroundColor = .orange
        cell.model = array[indexPath.row]
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate{
    
}
