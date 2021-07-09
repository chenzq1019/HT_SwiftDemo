//
//  HTRowIndexView.swift
//  电影院选座Demo
//
//  Created by 陈竹青 on 2021/7/9.
//

import UIKit

class HTRowIndexView: UIView {
    
    var height : CGFloat = 0 {
        willSet(newValue){
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: newValue)
            self.setNeedsDisplay()
        }
    }
    var indexsArray : Array<HTSeatsModel> = [] {
        willSet(array){
            self.setNeedsDisplay()
        }
    }
    var width: CGFloat = 0 {
        willSet(newValue){
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: newValue, height: self.frame.height)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.width = frame.width
        self.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width * 0.5
        self.layer.masksToBounds = true
    }
    
    override func draw(_ rect: CGRect) {
        let titleH = (CGFloat(self.height) - 2 * 10) / CGFloat( self.indexsArray.count)
     
        for (index,seatsModel) in self.indexsArray.enumerated() {
            let strId = NSString(string: seatsModel.rowId!)
            let strsize = strId.size(withAttributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 10),NSAttributedString.Key.foregroundColor:UIColor.white])
            strId.draw(at: CGPoint(x: self.width * 0.5 - strsize.width * 0.5, y: 10.0 + CGFloat(index) * titleH + titleH * 0.5 - strsize.height * 0.5) , withAttributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 10),NSAttributedString.Key.foregroundColor:UIColor.white])
        }
    }
    
}
