//
//  HTSeatButton.swift
//  电影院选座Demo
//
//  Created by 陈竹青 on 2021/7/9.
//

import UIKit
import SnapKit

let btnScale : CGFloat = 0.95

class HTSeatButton: UIButton {

    var seatmodel : HTSeatModel?
    var seatsmodel : HTSeatsModel?
    var seatIndex: Int?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnX = (self.frame.width - self.frame.width * btnScale) * 0.5
        let btnY = (self.frame.height - self.frame.height * btnScale) * 0.5
        let btnW = self.frame.width * btnScale
        let btnH = self.frame.height * btnScale
        self.imageView?.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
    }

}
