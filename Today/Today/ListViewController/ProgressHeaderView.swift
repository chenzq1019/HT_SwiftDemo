//
//  ProgressHeaderView.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/29.
//

import Foundation
import UIKit

class ProgressHeaderView: UICollectionReusableView{
    static var elementKind: String {UICollectionView.elementKindSectionHeader}
    
    var progerss: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
            heightConstraint?.constant = progerss * bounds.height
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.layoutIfNeeded()
            }
        }
    }
    
    private let upperView = UIView(frame: .zero)
    private let lowerView = UIView(frame: .zero)
    private let containerView  = UIView(frame: .zero)
    
    private var heightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubView()
        isAccessibilityElement = true
        accessibilityLabel = NSLocalizedString("Progress", comment: "Progress view accessibility label")
        accessibilityTraits.update(with: .updatesFrequently)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heightConstraint?.constant = progerss * bounds.height
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 0.5 * containerView.bounds.width
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareSubView(){
        containerView.addSubview(upperView)
        containerView.addSubview(lowerView)
        addSubview(containerView)
        
        upperView.translatesAutoresizingMaskIntoConstraints = false
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1).isActive = true
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        
        upperView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        upperView.bottomAnchor.constraint(equalTo: lowerView.topAnchor).isActive = true
        lowerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        upperView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        upperView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lowerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lowerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        heightConstraint = lowerView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true
        
        backgroundColor = .clear
        containerView.backgroundColor = .clear
        upperView.backgroundColor = .todayProgressUpperBackground
        lowerView.backgroundColor = .todayProgressLowerBackground
    }
}
