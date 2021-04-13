//
//  PrentViewController.swift
//  自定义转场动画
//
//  Created by 陈竹青 on 2020/12/25.
//

import UIKit

class PrentViewController: UIViewController {
    lazy var animation : HT_PresentAnimation = {
        let animation  = HT_PresentAnimation(type: .Aniamtion3DTransform, size: CGSize(width: UIScreen.main.bounds.width, height: 500))
        return animation
    }()
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.animation
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        // Do any additional setup after loading the view.
        let btn = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 40))
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(self.btnClick), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func btnClick(sender: UIButton)->Void{
        self.dismiss(animated: true) {
            print("dismiess")
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
