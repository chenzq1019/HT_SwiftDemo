//
//  PushViewController.swift
//  自定义转场动画
//
//  Created by 陈竹青 on 2020/12/30.
//

import UIKit

class PushViewController: UIViewController {
    var animation : HT_PushAnimation = {
        return HT_PushAnimation()
    }()
    
    var interactive: HT_PushTransitionInteractive = {
        let active = HT_PushTransitionInteractive()
        return active
    }()
    
    var imageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
        imageView.image = UIImage(named: "piao.png")
        return imageView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .custom
//        self.navigationController?.delegate = self.animation
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        self.view.addSubview(imageView)
        self.interactive.addPanGestureForViewController(viewController: self)
    }
    

}

extension PushViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
             animation.anitmaitonType = HT_PushAnimationType.pushType
        }
        else{
             animation.anitmaitonType = HT_PushAnimationType.popType
        }
        return animation
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animation.anitmaitonType == .popType {
            return self.interactive
        }
        return nil
    }
    
}
