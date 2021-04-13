//
//  HTGroupAnimationVC.swift
//  卡片动画
//
//  Created by 陈竹青 on 2021/4/2.
//

import UIKit

class HTGroupAnimationVC: UIViewController {
    var dataArray : [String] = ["同时","连续"]
    lazy var mCollection: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (kScreenWidth - 10)/2.0, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(HTBaseCollectionCell.self, forCellWithReuseIdentifier: "cellID")
        view.backgroundColor = UIColor(patternImage: UIImage(named: "02.png")!)
        return view
    }()
    lazy var demoView : UIView = {
        let view =  UIView(frame: CGRect.zero)
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(self.mCollection)
        self.mCollection.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.view.addSubview(self.demoView)
        self.demoView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.bottom.equalTo(self.view).offset(-100)
        }
    }
    

}

extension HTGroupAnimationVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HTBaseCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! HTBaseCollectionCell
        cell.titleLabel.text = self.dataArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.runAnimationFunc01()
        }
        if indexPath.row == 1 {
            self.runAnimationFunc02()
        }
//        let title : String = self.dataArray[indexPath.row]
//        if title == "关键帧"  {
//            self.keyframeAnimation()
//        }
//        if title == "路径" {
//            self.pathAnimation()
//        }
//        if title == "抖动" {
//            self.shakeAnimation()
//        }
    }
}

extension HTGroupAnimationVC{
    private func runAnimationFunc01(){
        //位移
        let animation1 = CAKeyframeAnimation(keyPath: "position")
        let value1 = CGPoint(x: 0, y: kScreenHeight/2 - 50)
        let value2 = CGPoint(x: kScreenWidth / 3, y: kScreenHeight/2 - 50)
        let value3 = CGPoint(x: kScreenWidth / 3, y: kScreenHeight/2 + 50)
        let value4 = CGPoint(x: kScreenWidth*2/3, y:  kScreenHeight/2 + 50)
        let value5 = CGPoint(x: kScreenWidth, y:  kScreenHeight/2 - 50)
        animation1.values = [value1,value2,value3,value4,value5]
        //缩放
        let animation2 = CABasicAnimation(keyPath: "transform.scale")
        animation2.fromValue = 0.8
        animation2.toValue = 2.0
        
        //旋转
        let animation3 = CABasicAnimation(keyPath: "transform.rotation")
        animation3.toValue = CGFloat(Double.pi * 4)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation1,animation2,animation3]
        groupAnimation.duration = 4.0
        
        self.demoView.layer.add(groupAnimation, forKey: "groupAnimation")
        
    }
    
    private func runAnimationFunc02(){
        let currentTime = CACurrentMediaTime()
        
        //位移
        let animation1 = CABasicAnimation(keyPath: "position")
        animation1.fromValue =  CGPoint(x: 0, y: kScreenHeight/2 - 75)
        animation1.toValue = CGPoint(x: kScreenWidth / 2, y: kScreenHeight/2 - 75)
        animation1.beginTime = currentTime
        animation1.duration = 1.0
        animation1.fillMode = .forwards
        animation1.isRemovedOnCompletion = false
        self.demoView.layer.add(animation1, forKey: "position")
        //缩放
        let animation2 = CABasicAnimation(keyPath: "transform.scale")
        animation2.fromValue = 0.8
        animation2.toValue = 2.0
        animation2.beginTime = currentTime + 1
        animation2.duration = 1
        animation2.fillMode = .forwards
        animation2.isRemovedOnCompletion = false
        self.demoView.layer.add(animation2, forKey: "scale")
        
        //旋转
        let animation3 =  CABasicAnimation(keyPath: "transform.rotation")
        animation3.toValue = CGFloat(Double.pi * 4)
        animation3.beginTime = currentTime + 2
        animation3.duration = 1
        animation3.isRemovedOnCompletion = false
        animation3.fillMode = .forwards
        self.demoView.layer.add(animation3, forKey: "rotation")
        
        
        //缩放
        let animation4 = CABasicAnimation(keyPath: "transform.scale")
        animation4.fromValue = 2
        animation4.toValue = 0.8
        animation4.beginTime = currentTime + 3
        animation4.duration = 1
        animation4.isRemovedOnCompletion = false
        animation4.fillMode = .forwards
        self.demoView.layer.add(animation4, forKey: "calele2")
        
        //
        
    
    }
}
