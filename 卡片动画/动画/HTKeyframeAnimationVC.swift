//
//  HTKeyframeAnimationVC.swift
//  卡片动画
//
//  Created by 陈竹青 on 2021/4/1.
//

import UIKit

class HTKeyframeAnimationVC: UIViewController {
    lazy var demoView : UIView = {
        let view =  UIView(frame: CGRect.zero)
        view.backgroundColor = .red
        return view
    }()
    
    var dataArray : [String] = ["关键帧","抖动","路径"]
    
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

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.view.addSubview(self.mCollection)
        self.mCollection.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.view.addSubview(self.demoView)
        self.demoView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-50)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
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

extension HTKeyframeAnimationVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
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
        if title == "关键帧"  {
            self.keyframeAnimation()
        }
        if title == "路径" {
            self.pathAnimation()
        }
        if title == "抖动" {
            self.shakeAnimation()
        }
    }
}

extension HTKeyframeAnimationVC{
    private func keyframeAnimation(){
        let animation = CAKeyframeAnimation(keyPath: "position")
        let value01 = CGPoint(x: 0, y: kScreenHeight/2 - 50)
        let value02 = CGPoint(x: kScreenWidth/3, y: kScreenHeight/2 - 50)
        let value03 = CGPoint(x: kScreenWidth/3, y: kScreenHeight/2 + 50)
        let value04 = CGPoint(x: kScreenWidth*2/3, y: kScreenHeight/2 - 50)
        let value05 = CGPoint(x: kScreenWidth, y: kScreenHeight/2 - 50)
        animation.values = [value01,value02,value03,value04,value05]
        animation.duration = 2.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        self.demoView.layer.add(animation, forKey: "positionKeyframe")
    }
    
    private func pathAnimation(){
        let animation = CAKeyframeAnimation(keyPath: "position")
        let path = UIBezierPath(ovalIn: CGRect(x: kScreenWidth/2 - 100, y: kScreenHeight/2 - 100, width: 200, height: 200))
        animation.path = path.cgPath
        animation.duration = 2.0
        self.demoView.layer.add(animation, forKey: "")
    }
    
    private func shakeAnimation(){
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        let value01 = -CGFloat(Double.pi/180 * 4)
        let value02 = CGFloat(Double.pi/180 * 4)
        let value03 = -CGFloat(Double.pi/180 * 4)
        animation.values = [value01,value02,value03]
        animation.repeatCount = MAXFLOAT
        self.demoView.layer.add(animation, forKey: "shake")
    }
}
