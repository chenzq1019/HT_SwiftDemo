//
//  HTTransitionAnimationVC.swift
//  卡片动画
//
//  Created by 陈竹青 on 2021/4/1.
//

import UIKit

class HTTransitionAnimationVC: UIViewController {
    var dataArray : [[String:String]] = [["淡入淡出":"fade"],["推挤":"moveIn"],["揭开":"push"],["覆盖":"reveal"],["立方体":"cube"],["吸收":"suckEffect"],["翻转":"oglFlip"],["波纹":"rippleEffect"],["翻页":"pageCurl"],["反翻页":"pageCurl"],["开镜头":"cameraIrisHollowOpen"],["关镜头":"cameraIrisHollowClose"],["下翻页":"pageCurl"],["上翻页":"pageCurl"],["左翻页":"pageCurl"],["右翻页":"pageCurl"]]
//    var animationType: [String] = [".fade",".moveIn","reveal","cube","suckEffect","oglFlip","rippleEffect","pageCurl","cameraIrisHollowOpen","cameraIrisHollowClose",]
    
    var currentType : String!
    
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
    var toView : UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toView = UIView(frame: self.view.frame)
        self.toView.backgroundColor = .yellow
        let btn = UIButton()
        btn.setTitle("click At", for: .normal)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(clickAtBtn), for: .touchUpInside)
        self.toView.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.center.equalTo(self.toView)
        }
        self.view.addSubview(self.toView)
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "02.png")!)
        self.view.addSubview(self.mCollection)
        self.mCollection.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }

    }
    
    @objc func clickAtBtn(){
        self.htTransition(type: self.currentType, subType: nil, view: self.view)
    }

}

extension HTTransitionAnimationVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HTBaseCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! HTBaseCollectionCell
        let dic = self.dataArray[indexPath.row]
        for key in dic.keys {
            cell.titleLabel.text = key
        }
//        cell.titleLabel.text =
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let title : String = self.dataArray[indexPath.row]
        let dic = self.dataArray[indexPath.row]
        var type: String = ""
        for value in dic.values {
            type = value
        }
        self.currentType = type
//        let type : String = self.animationType[indexPath.row]
        self.htTransition(type: type , subType: nil, view: self.view)
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


extension HTTransitionAnimationVC{
    private func htTransition(type:String,subType: CATransitionSubtype?, view: UIView) ->Void{
        let animation : CATransition = CATransition()
        animation.duration = 0.7
        if type == "fade" {
            animation.type = .fade
            animation.subtype = .fromLeft
        }else
        if type == "moveIn" {
            animation.type = .moveIn
            animation.subtype = .fromBottom
        }else
        if type == "push" {
            animation.type = .push
            animation.subtype = .fromRight
        }else
        
        if type == "reveal" {
            animation.type = .reveal
            animation.subtype = .fromTop
        }else{
            animation.type = CATransitionType(rawValue: type)
        }
        
//        if let sub = subType {
//            animation.subtype = sub
//        }
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        self.view.exchangeSubview(at: 1, withSubviewAt: 0)
        view.layer.add(animation, forKey: "animation")
    }
    
    private func animationWithView(view: UIView, transition: UIView.AnimationTransition){
        
        UIView.animate(withDuration: 0.7) {
            UIView.setAnimationCurve(UIView.AnimationCurve.easeOut)
            UIView.setAnimationTransition(transition, for: view, cache: true)
        }
   
    }
}
