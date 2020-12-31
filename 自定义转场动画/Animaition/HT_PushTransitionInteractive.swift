//
//  HT_PushTransitionInteractive.swift
//  自定义转场动画
//
//  Created by 陈竹青 on 2020/12/31.
//

import UIKit

class HT_PushTransitionInteractive: UIPercentDrivenInteractiveTransition{
    weak var viewController: UIViewController?
    var isInteractive = false
    
    func addPanGestureForViewController(viewController: UIViewController) -> Void {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handleGesture))
        self.viewController = viewController
        viewController.view.addGestureRecognizer(pan)
    }
    
    @objc func handleGesture(gesture: UIPanGestureRecognizer)->Void{
        let translation : CGPoint = gesture.translation(in: gesture.view)
        var complate : CGFloat = 0.0
        guard let controller = self.viewController else {
            return
        }
        complate =  translation.x / controller.view.frame.width
        complate = abs(complate)
        switch gesture.state {
        case .began:
            self.isInteractive = true
            self.viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            self.update(complate)
        case .ended:
            self.isInteractive = false
            if percentComplete > 0.5 {
                self.finish()
            }else {
                self.cancel()
            }
        default:
            break
        }
    }
    

}

