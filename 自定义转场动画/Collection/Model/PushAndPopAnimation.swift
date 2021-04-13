//
//  PushAndPopAnimation.swift
//  自定义转场动画
//
//  Created by 陈竹青 on 2021/3/29.
//

import UIKit

class PushAndPopAnimation: NSObject , UIViewControllerAnimatedTransitioning{
    
    let coverEdgInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let coverViewBackgroundColor = UIColor.darkGray
    let horizeontalCount = 5
    var verticalCount = 1
    var horizontalGap: CGFloat = 0
    var verticalGap : CGFloat = 0
    
    private let kAnimationDuration : Double = 0.0
    private let kCellAnimationSmallDelta : Double = 0.01
    private let kCellAnimationBigDelta : Double = 0.03
    
    private var operation : UINavigationController.Operation
    
    init(operation: UINavigationController.Operation) {
        self.operation = operation
        super.init()
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return kAnimationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from) as? GallerisViewController
        let toVC = transitionContext.viewController(forKey: .to)
        let fromView = transitionContext.view(forKey: .from) as? UICollectionView
        let toView = transitionContext.view(forKey: .to)
        
        let duration = transitionDuration(using: transitionContext)
        switch operation {
        case .push:
            print("")
            let selectCell = fromView?.cellForItem(at: fromVC!.selectedIndexPath as IndexPath)
            selectCell?.isHidden = true
            
            let layoutAttributes = fromVC?.myCollection.layoutAttributesForItem(at: fromVC!.selectedIndexPath as IndexPath)
            
            let areaRect = fromVC?.myCollection.convert(layoutAttributes!.frame, to: fromVC!.myCollection.superview)
            
            toVC?.coverRectInSuperview = areaRect
            
            toVC?.view.layoutIfNeeded()
            
//            setupViewsibleCellBeforPush(toVC!)
            transitionContext.containerView.addSubview(toView!)
            
//            let fakeCoverView = createAndSetupFakeCoverView(fromVC!, toVC: toVC!)
            let options : UIView.KeyframeAnimationOptions = [.beginFromCurrentState,.overrideInheritedOptions,.calculationModeCubic,.calculationModeCubicPaced]
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: options) {
                
            } completion: { (finish) in
                
            }
            

        
            
            
            
            
            
            
        
        case .pop:
            print("")
        
        default: break
            
        }
    }
    
}
