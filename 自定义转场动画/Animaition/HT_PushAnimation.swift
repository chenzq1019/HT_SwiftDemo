//
//  HT_PushAnimation.swift
//  自定义转场动画
//
//  Created by 陈竹青 on 2020/12/30.
//

import UIKit

enum HT_PushAnimationType {
    case pushType
    case popType
}

class HT_PushAnimation: NSObject {
    
    var type : HT_PushAnimationType = .pushType
    
    
    var anitmaitonType : HT_PushAnimationType {
        set(type){
            self.type = type
        }
        get{
            return self.type
        }
    }
    
    override init() {
        super.init()
    }
    
}

extension HT_PushAnimation:UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        if type == .pushType {
            guard let toVc = transitionContext.viewController(forKey: .to) as? PushViewController else {return}
            guard let fromVc = transitionContext.viewController(forKey: .from) as? ViewController else{return}
            let cell = fromVc.mTableView.cellForRow(at: fromVc.currentIndexPath!)
            let containter = transitionContext.containerView
            let imageViewCopy = cell?.imageView?.snapshotView(afterScreenUpdates: false)
            imageViewCopy?.frame = (cell?.imageView?.convert((cell?.imageView!.bounds)!, to: containter))!
            toVc.imageView.isHidden = true
            containter.addSubview(toVc.view)
            containter.addSubview(imageViewCopy!)
            //
            UIView.animate(withDuration:  transitionDuration(using: transitionContext)) {
                imageViewCopy?.frame = toVc.imageView.convert(toVc.imageView.bounds, to: containter)
                
            } completion: { (finished: Bool) in
                toVc.imageView.isHidden = false
                imageViewCopy?.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }else{
            guard let toVc = transitionContext.viewController(forKey: .to) as? ViewController else {return}
            guard let fromVc = transitionContext.viewController(forKey: .from) as? PushViewController else{return}
            
            let cell = toVc.mTableView.cellForRow(at: toVc.currentIndexPath!)
            let container = transitionContext.containerView
            let imageViewCopy = fromVc.imageView.snapshotView(afterScreenUpdates: false)
            imageViewCopy?.frame = fromVc.imageView.convert(fromVc.imageView.bounds, to: container);
            fromVc.imageView.isHidden = true
            container.addSubview(toVc.view)
            //背景图
            let bgView = UIView(frame: fromVc.view.bounds)
            bgView.backgroundColor = UIColor.white
            container.addSubview(bgView)
            container.addSubview(imageViewCopy!)
            UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
                imageViewCopy?.frame = (cell?.imageView?.convert((cell?.imageView!.bounds)!, to: container))!
//                bgView.alpha = 0
            } completion: { (finished: Bool) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                if transitionContext.transitionWasCancelled{
                    fromVc.imageView.isHidden = false
                }
                imageViewCopy?.removeFromSuperview()
                bgView.removeFromSuperview()
            }

            
        }


    }
    
}



//extension HT_PushAnimation:UINavigationControllerDelegate{
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self
//    }
//    
//}
