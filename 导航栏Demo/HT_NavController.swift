//
//  HT_NavController.swift
//  导航栏Demo
//
//  Created by 陈竹青 on 2021/10/8.
//

import Foundation
import UIKit

 extension UIViewController {
    
    fileprivate struct AssocitatedKyes {
        static var navBarBgAlpha : CGFloat = 1.0
    }
    
    var navBarBgAlpha: CGFloat {
        get {
            let alpha = objc_getAssociatedObject(self, &AssocitatedKyes.navBarBgAlpha) as? CGFloat
            if alpha == nil {
                return 1.0
            }else{
                return alpha!
            }
        }
        set {
            var alpha = newValue
            if alpha > 1 {
                alpha = 1
            }
            if alpha < 0 {
                alpha = 0
            }
            objc_setAssociatedObject(self, &AssocitatedKyes.navBarBgAlpha, alpha, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.navigationController?.setNeedsNavigationBackground(alpha: alpha)
        }
    }
    
}

extension UINavigationController{
    
    class func Test(){
        
    }
    
    fileprivate  func setNeedsNavigationBackground(alpha:CGFloat){
        let barBackgroudnView = navigationBar.value(forKey: "_barBackgroundView") as AnyObject
        let backgroundImageView = barBackgroudnView.value(forKey:"_backgroundImageView") as? UIImageView
        if navigationBar.isTranslucent {
            if backgroundImageView != nil && backgroundImageView!.image != nil{
                (backgroundImageView!).alpha = alpha
            }else{
                if let backgroundEffectView = barBackgroudnView.value(forKey:"_backgroundEffectView") as? UIView {
                    backgroundEffectView.alpha = alpha
                }
            }
        }else{
            (barBackgroudnView as! UIView).alpha = alpha
        }
        if let shadowView = barBackgroudnView.value(forKey:"_shadowView") as? UIView {
            shadowView.alpha = alpha
        }
    }
    
    
    @objc public class func swiftyLoad(){
           
           if self == UINavigationController.self {
               let originalSelectorArr = ["_updateInteractiveTransition:"]
               //method swizzling
               for ori in originalSelectorArr {
                   let originalSelector = NSSelectorFromString(ori)
                   let swizzledSelector = NSSelectorFromString("et_\(ori)")
                   let originalMethod = class_getInstanceMethod(self.classForCoder(), originalSelector)
                   let swizzledMethod = class_getInstanceMethod(self.classForCoder(), swizzledSelector)
                    method_exchangeImplementations(originalMethod!, swizzledMethod!)
               }
               
           }
           
       }
       

       func et__updateInteractiveTransition(_ percentComplete: CGFloat) {
           et__updateInteractiveTransition(percentComplete)
           let topVC = self.topViewController
           if topVC != nil {
               //transitionCoordinator带有两个VC的转场上下文
               let coor = topVC?.transitionCoordinator
               if coor != nil {
                   //fromVC 的导航栏透明度
                   let fromAlpha = coor?.viewController(forKey: .from)?.navBarBgAlpha
                   //toVC 的导航栏透明度
                   let toAlpha = coor?.viewController(forKey: .to)?.navBarBgAlpha
                   //计算当前的导航栏透明度
                   let nowAlpha = fromAlpha! + (toAlpha!-fromAlpha!)*percentComplete
                   //设置导航栏透明度
                   self.setNeedsNavigationBackground(alpha: nowAlpha)
               }
           }
           
       }
}
