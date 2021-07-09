//
//  HTIndicatorView.swift
//  电影院选座Demo
//
//  Created by 陈竹青 on 2021/7/9.
//

import UIKit

class HTIndicatorView: UIView {
    
    var viewRatio : CGFloat = 0.0
    var mapView : UIView?
    var myScrollView : UIScrollView?

    init(frame: CGRect,mapView: UIView,ratio:CGFloat,myScrollView:UIScrollView) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
