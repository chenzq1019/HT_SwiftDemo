//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by 陈竹青 on 2021/1/12.
//

import UIKit
let gap = (UIScreen.main.bounds.size.width - 5 * 10) / 6
class ViewController: UIViewController {
    var animator : UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collison : UICollisionBehavior!
//    var firstContact = false
    var square : UIView!
    var snap : UISnapBehavior!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let startX = CGFloat(arc4random() % UInt32((UIScreen.main.bounds.width - gap)))
        square = UIView(frame: CGRect(x: startX, y: 10, width: gap - 20 , height: gap - 20))
        square.backgroundColor = .gray
        square.layer.cornerRadius = (gap - 20) / 2.0
        view.addSubview(square)
        
        //处理碰撞
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
        barrier.backgroundColor = .red
//        view.addSubview(barrier)
        //UIDynamicAnimator是UIKit的物理引擎。这个类能够跟踪你添加的各种行为，如重力，并提供整体上下文。
        animator = UIDynamicAnimator(referenceView: view)
        //UIGravityBehavior是重力行为的模型，可以给一个或多个item施加力度，让你模拟物理相互作用。
        gravity = UIGravityBehavior(items: [square])
        animator.addBehavior(gravity)
        //碰撞，创建了一个碰撞检测行为，
        //不是直接用坐标描绘边界，另外还是设置属性translatesReferenceBoundsIntoBoundary为true。
        collison = UICollisionBehavior(items: [square])
        collison.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collison)
        
        //
//        collison.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrier.frame))
        
        for j in 0...7 {
            for i in 0..<5 {
                let x = j % 2 == 0 ? gap  : gap * 3  / 2.0
                let dot = UIView(frame: CGRect(x: x   + (gap + 10) * CGFloat(i), y: 150  + ((gap+20) * CGFloat(j))  , width: 5, height: 5))
                dot.layer.cornerRadius = 5
                dot.backgroundColor = .red
                view.addSubview(dot)
                collison.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: dot.frame))
            }
        }
        for i in 0...5 {
            let bottom = UIView(frame: CGRect(x: gap + (gap + 10) * CGFloat(i), y:  UIScreen.main.bounds.size.height - 100, width: 10, height: 100))
            bottom.backgroundColor = .red
            view.addSubview(bottom)
            collison.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: bottom.frame))
        }
        
        //
        collison.action = {
//            print("\(NSCoder.string(for: square.transform)) \(NSCoder.string(for: square.center))")
        }
        //添加碰撞的通知代理
        collison.collisionDelegate = self
        
        //配置属性
        /**
         *
         *elasticity – 确定在碰撞时有多大的弹性
         friction – 确定在沿表面滑动时有多少阻力
         density – 结合size时，会给item一个总质量，质量越大越难加速，质量越大减速越快。
         resistance – 确定在直线移动时会收到多少阻力。跟friction的区别是，这仅适用于滑动。
         angularResistance – 确定在旋转运动时会收到多少阻力。
         allowsRotation – 这是个有趣的属性，它并不模拟真实世界的物理特性。当它设置为NO时便不会再旋转，无论有多少旋转力度。
         */
        let itemBehavior = UIDynamicItemBehavior(items: [square])
        itemBehavior.elasticity = 0.6
        animator.addBehavior(itemBehavior)
        

    }


}

extension ViewController: UICollisionBehaviorDelegate{
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        
    }
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        print("Boundary contact occurred - \(identifier)")
        let collidingView = item as? UIView
        if let itemView = collidingView {
            itemView.backgroundColor = .yellow
            UIView.animate(withDuration: 0.3) {
                itemView.backgroundColor = .gray
            }
//            if !firstContact {
//                firstContact = true
//                let squere = UIView(frame: CGRect(x: 30, y: 0, width: 100, height: 100))
//                squere.backgroundColor = .gray
//                view.addSubview(squere)
//                collison.addItem(squere)
//                gravity.addItem(squere)
//                let attach = UIAttachmentBehavior(item: itemView, attachedTo: squere)
//                animator.addBehavior(attach)
//            }
        }

    }
    
}

extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if snap != nil {
//            animator.removeBehavior(snap)
//        }
//        let touch = touches.first
//        snap = UISnapBehavior(item: square, snapTo: (touch?.location(in: view))!)
//        animator.addBehavior(snap)
        
        let startX = CGFloat(arc4random() % UInt32((UIScreen.main.bounds.width - gap)))
        let square = UIView(frame: CGRect(x: startX, y: 10, width: gap - 20 , height: gap - 20))
        square.backgroundColor = .gray
        square.layer.cornerRadius = (gap - 20) / 2.0
        view.addSubview(square)
        collison.addItem(square)
        gravity.addItem(square)
        
        
    }
}
