//
//  HTImageCell.swift
//  CollectionViewDemo
//
//  Created by 陈竹青 on 2021/8/13.
//

import UIKit

class HTImageCell: UICollectionViewCell {
    var imageView: UIImageView!
    var gradientLayer:CAGradientLayer?
    var hilightedCover:UIView!
    
    var originalCenter: CGPoint?
    var cellFrame: CGRect?
    var indexPath: IndexPath?
    
    override var isHighlighted: Bool{
        didSet{
            hilightedCover.isHidden = !isHighlighted
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        imageView.frame = bounds
//        hilightedCover.frame = frame
        applyGradation(imageView)
    }
    
    private func configure(){
        imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        hilightedCover = UIView()
        hilightedCover.backgroundColor = UIColor(white: 0, alpha: 0.5)
        hilightedCover.isHidden = true
        self.contentView.addSubview(hilightedCover)
        hilightedCover.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
    }
    
    private func applyGradation(_ gradientView:UIView){
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = nil
        gradientLayer = CAGradientLayer()
        gradientLayer!.frame = gradientView.bounds
        let mainColor = UIColor(white: 0, alpha: 0.3).cgColor
        let subColor = UIColor.clear.cgColor
        gradientLayer!.colors = [subColor, mainColor]
        gradientLayer!.locations = [0, 1]
        gradientView.layer.addSublayer(gradientLayer!)
    }
    
    func pushFowardView() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseInOut, .beginFromCurrentState],
            animations: {
                self.center = self.originalCenter!
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//                self.cellFakeHightedView!.alpha = 0;
                let shadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
                shadowAnimation.fromValue = 0
                shadowAnimation.toValue = 0.7
                shadowAnimation.isRemovedOnCompletion = false
                shadowAnimation.fillMode = CAMediaTimingFillMode.forwards
                self.layer.add(shadowAnimation, forKey: "applyShadow")
            },
            completion: { _ in
//                self.cellFakeHightedView?.removeFromSuperview()
            }
        )
    }
    
    func pushBackView(_ finish:(()->Void)?) -> Void {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut,.beginFromCurrentState]) {
            self.transform = CGAffineTransform.identity
            self.frame = self.cellFrame!
            let shadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
            shadowAnimation.fromValue = 0.7
            shadowAnimation.toValue = 0
            shadowAnimation.isRemovedOnCompletion = false
            shadowAnimation.fillMode = CAMediaTimingFillMode.forwards
            self.layer.add(shadowAnimation, forKey: "removeShadow")
            
        } completion: { (_) in
            finish?()
        }

    }
}
