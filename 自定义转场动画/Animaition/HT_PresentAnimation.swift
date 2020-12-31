//
//  HT_PresentAnimation.swift
//  自定义转场动画
//
//  Created by 陈竹青 on 2020/12/25.
//

import UIKit

enum HT_PresentType {
    case AniamtionSheetType
    case Aniamtion3DTransform
    case AniamtionAlertType
}

class HT_PresentAnimation: NSObject {
    var animatTime : CGFloat = 0.4
    var animationType : HT_PresentType?
    //计算属性是赋值其他属性，或者从其他属性获取值，自己并不会存储值。可以理解为一个方法
    var type : HT_PresentType? {
        set(value){
            self.animationType = value
        }
        get{
            return self.animationType
        }
    }
    var viewSize : CGSize = CGSize.zero
    
    override init() {
        super.init()
    }
    
    init(type:HT_PresentType,size: CGSize) {
        super.init()
        animationType = type
        viewSize = size
        if type == .Aniamtion3DTransform {
            animatTime = 0.4
        }else {
            animatTime = 0.3
        }
    }
}


extension HT_PresentAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Double(animatTime)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVc = transitionContext.viewController(forKey: .to)
        let fromVc = transitionContext.viewController(forKey: .from)
        if ((toVc?.isBeingPresented) == true) {
            switch animationType {
            case .Aniamtion3DTransform:
                present3DAnimationWithTransitionContext(transitionContext: transitionContext)

            case .AniamtionSheetType:
                presentSheetTypeWithTransitionContext(transitionContext: transitionContext)
            case .AniamtionAlertType:
                presentAlertTypeWithTransitionContext(transitionContext: transitionContext)
            default:
                return
            }
        }
        if fromVc?.isBeingDismissed == true {
            switch animationType {
            case .Aniamtion3DTransform:
                dismiss3DAnimainWithTransitionContext(transitionContext: transitionContext)
            case .AniamtionSheetType:
                dismissSheetTypeWithTransitionContext(transitionContext: transitionContext)
            case .AniamtionAlertType:
                dismissAlertTypeWithTransitionContext(transitionContext: transitionContext)
            default:
                return
            }
            
        }
    }
}


extension HT_PresentAnimation {
    fileprivate func present3DAnimationWithTransitionContext(transitionContext:UIViewControllerContextTransitioning){
        guard let toVc = transitionContext.viewController(forKey: .to) else {return}
        guard let fromVc = transitionContext.viewController(forKey: .from) else{return}
        //截取全屏图片
        guard let tempView = fromVc.view.snapshotView(afterScreenUpdates: false) else {return}
        tempView.frame = (fromVc.view.frame)
        fromVc.view.isHidden = true
        //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视
        let containerView  = transitionContext.containerView
        containerView.addSubview(tempView)
        containerView.addSubview(toVc.view)
        
        toVc.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: viewSize.width, height: viewSize.height)
        
        toVc.view.layer.zPosition = 500
        tempView.layer.zPosition = 400
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            toVc.view.transform = CGAffineTransform(translationX: 0, y: -self.viewSize.height)
            var transform : CATransform3D = CATransform3DIdentity
            transform.m34 = 1.0 / -300
            tempView.layer.shadowOpacity = 0.01
            tempView.layer.transform = CATransform3DRotate(transform,CGFloat(8*(Double.pi)/180), 1, 0, 0)
            
        } completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.3) {
                tempView.layer.setAffineTransform(CGAffineTransform(scaleX: 0.93, y: 0.93))
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if transitionContext.transitionWasCancelled {
                fromVc.view.isHidden =  true
                tempView.removeFromSuperview()
            }
        }
        
    }
    
    fileprivate func dismiss3DAnimainWithTransitionContext(transitionContext:UIViewControllerContextTransitioning) ->Void{
        guard let toVc = transitionContext.viewController(forKey: .to) else {return}
        guard let fromVc = transitionContext.viewController(forKey: .from) else{return}
        //截取全屏图片
        guard let tempView = transitionContext.containerView.subviews.first else {return}
        
        fromVc.view.layer.zPosition = 500
        tempView.layer.zPosition = 400
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            fromVc.view.transform =  CGAffineTransform.identity
            var transform : CATransform3D = CATransform3DIdentity
            transform.m34 = 1.0 / 300
            tempView.layer.shadowOpacity = 0.01
            tempView.layer.transform = CATransform3DRotate(transform,CGFloat(-10*(Double.pi)/180), 1, 0, 0)
            
        } completion: { (finish: Bool) in
            UIView.animate(withDuration: 0.3) {
                tempView.layer.setAffineTransform(CGAffineTransform(scaleX: 1, y:1))
            } completion: { (finshed: Bool) in
                if transitionContext.transitionWasCancelled {
                    transitionContext.completeTransition(false)
                }else{
                    transitionContext.completeTransition(true)
                    toVc.view.isHidden = false
                    tempView.removeFromSuperview()
                }
            }
            
        }

    }
    fileprivate func presentSheetTypeWithTransitionContext(transitionContext:UIViewControllerContextTransitioning)->Void{
        guard let toVc = transitionContext.viewController(forKey: .to) else {return}
        guard let fromVc = transitionContext.viewController(forKey: .from) else{return}
        
        let backgroudView = UIView(frame: fromVc.view.frame)
        backgroudView.backgroundColor = UIColor.black
        backgroudView.alpha = 0.0
        backgroudView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(sender:)))
        backgroudView.addGestureRecognizer(tap)
        
        let containerView = transitionContext.containerView
        containerView.addSubview(backgroudView)
        containerView.addSubview(toVc.view)
        
        toVc.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: viewSize.width, height: viewSize.height)
        //开始动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            toVc.view.transform = CGAffineTransform(translationX: 0, y:  -self.viewSize.height)
            backgroudView.alpha = 0.4
        } completion: { (finished: Bool) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if transitionContext.transitionWasCancelled {
                fromVc.view.isHidden =  false
                backgroudView.removeFromSuperview()
            }
        }

    }
    
    fileprivate func dismissSheetTypeWithTransitionContext(transitionContext:UIViewControllerContextTransitioning)->Void{
        guard let toVc = transitionContext.viewController(forKey: .to) else {return}
        guard let fromVc = transitionContext.viewController(forKey: .from) else{return}
      
        guard let tempView = transitionContext.containerView.subviews.first else {return}
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            fromVc.view.transform =  CGAffineTransform.identity
            tempView.alpha = 0.0
        } completion: { (finished: Bool) in

            if transitionContext.transitionWasCancelled {
                transitionContext.completeTransition(false)
            }else{
                transitionContext.completeTransition(true)
                toVc.view.isHidden = false
                tempView.removeFromSuperview()
            }
        }

    }
    
    fileprivate func presentAlertTypeWithTransitionContext(transitionContext:UIViewControllerContextTransitioning)->Void{
        guard let toVc = transitionContext.viewController(forKey: .to) else {return}
        guard let fromVc = transitionContext.viewController(forKey: .from) else{return}
        
        let screenH = UIScreen.main.bounds.height
        let scrrenW = UIScreen.main.bounds.width
        toVc.view.frame = CGRect(x: (scrrenW - viewSize.width) / 2.0, y: (screenH - viewSize.height)/2.0, width: viewSize.width, height: viewSize.height)
        transitionContext.containerView.addSubview(toVc.view)
        toVc.view.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            toVc.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        } completion: { (finiseh:Bool) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if transitionContext.transitionWasCancelled {
                fromVc.view.isHidden =  false
            }
        }
    }
    
    fileprivate func dismissAlertTypeWithTransitionContext(transitionContext:UIViewControllerContextTransitioning) ->Void{
        guard let toVc = transitionContext.viewController(forKey: .to) else {return}
        guard let fromVc = transitionContext.viewController(forKey: .from) else{return}
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            fromVc.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            fromVc.view.alpha = 0.0
        } completion: { (finished: Bool) in
            if transitionContext.transitionWasCancelled {
                transitionContext.completeTransition(false)
            }else{
                transitionContext.completeTransition(true)
                toVc.view.isHidden = false
            }
        }

    }
    
    @objc func tapClick(sender: UIGestureRecognizer)->Void{
        
    }
}


extension HT_PresentAnimation:UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
