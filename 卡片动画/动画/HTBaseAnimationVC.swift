//
//  HTBaseAnimationVC.swift
//  卡片动画
//
//  Created by 陈竹青 on 2021/4/1.
//

/**
    rotaion.x   旋转，弧度，X轴
    rotaion.y   旋转，弧度，Y轴
    rotaion.z旋转，弧度，Z轴
    rotaion旋转，弧度，Z轴，完全等同于
    rotation.zscale.x缩放，X轴
    scale.y缩放，Y轴
    scale.z缩放，Z轴scale缩放，XYZ轴
    translation.x移动，X轴
    translation.y移动，Y轴
    translation.z移动，Z轴
    translation移动，XY轴，value值为NSSize或者CGSize类型
    opacity等zPosition、frame、backgroundColor、cornerRadius类似的layer中的各种属性
 **/

import UIKit

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

class HTBaseAnimationVC: UIViewController {
    
    lazy var demoView : UIView = {
        let view =  UIView(frame: CGRect.zero)
        view.backgroundColor = .red
        return view
    }()
    
    var dataArray : [String] = ["位移","透明度","缩放","旋转","背景颜色","电灯"]
    
    lazy var mCollection: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (kScreenWidth - 10)/2.0, height: 60)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(HTBaseCollectionCell.self, forCellWithReuseIdentifier: "cellID")
        view.backgroundColor = .systemGray6
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(self.mCollection)
        self.mCollection.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.view.addSubview(self.demoView)
        self.demoView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-50)
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.centerX.equalTo(self.view)
        }
        
        // Do any additional setup after loading the view.
    }
    

}

extension HTBaseAnimationVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HTBaseCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! HTBaseCollectionCell
        cell.titleLabel.text = self.dataArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title : String = self.dataArray[indexPath.row]
        if title == "位移"  {
            self.positionAnimation()
        }
        if title == "透明度" {
            self.opacityAnimation()
        }
        if title == "缩放" {
            self.scaleAnimation()
        }
        if title == "旋转" {
            self.rotatoAnimaition()
        }
        if title == "背景颜色" {
            self.backgroundColorAnimation()
        }
    }
}

extension HTBaseAnimationVC {
    
    private func positionAnimation() ->Void{
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = CGPoint(x: 0, y: kScreenHeight - 150)
        animation.toValue = CGPoint(x: kScreenWidth-100, y: kScreenHeight - 150)
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        self.demoView.layer.add(animation, forKey: "postionAnimation")
    }
    
    private func opacityAnimation(){
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 1.0
        self.demoView.layer.add(animation, forKey: "opacityAnimation")
    }
    
    private func scaleAnimation(){
        //方法一通过scale
//        let animation = CABasicAnimation(keyPath: "transform.scale")
//        animation.toValue = 2.0
//        animation.duration = 1.0
//        self.demoView.layer.add(animation, forKey: "scaleAnimation")
        
        //方法二通过bounds
//        let animation2 = CABasicAnimation(keyPath: "bounds")
//        animation2.toValue = CGRect(x: 0, y: 0, width: 200, height: 200)
//        animation2.duration = 1.0
//        self.demoView.layer.add(animation2, forKey: "boundsAnimation")
        
        
        //方式三通过缩放单独的x或y
        let animation3 = CABasicAnimation(keyPath: "transform.scale.x")
        animation3.toValue = 2
        animation3.duration = 1.0
        self.demoView.layer.add(animation3, forKey: "scale-x")
    }
    
    private func rotatoAnimaition(){
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = CGFloat(Double.pi * 3)
        animation.duration = 1.0
        self.demoView.layer.add(animation, forKey: "rotationAnimation")
    }
    
    private func backgroundColorAnimation(){
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.toValue = UIColor.blue.cgColor
        animation.duration = 1.0
        self.demoView.layer.add(animation, forKey: "backgroudColorAnimation")
    }
}
