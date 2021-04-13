//
//  HT_DrawPaint.swift
//  绘图板Demo
//
//  Created by 陈竹青 on 2020/12/25.
//

import UIKit

class HT_DrawPaint: UIBezierPath {
     
     init(width: CGFloat,color: UIColor) {
        super.init()
        self.lineWidth = width
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
