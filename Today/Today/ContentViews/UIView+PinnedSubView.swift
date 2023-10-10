//
//  UIView+PinnedSubView.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/28.
//

import UIKit

extension UIView {
    func addPinnedSubView(_ subView: UIView, height: CGFloat? = nil,insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)){
        addSubview(subView)
        //prevent the system from creating automatic constraints for this view.
        subView.translatesAutoresizingMaskIntoConstraints = false
        //通过添加并激活顶部锚定约束，将子视图固定到父视图的顶部。
        subView.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        //通过添加并激活顶部锚定约束，将子视图固定到父视图的左边。
        subView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = translatesAutoresizingMaskIntoConstraints
        //，将子视图固定到父视图的右边。
        subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * insets.right).isActive = true
        //，将子视图固定到父视图的下边。
        subView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * insets.bottom).isActive = true
        if let height = height {
            subView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
