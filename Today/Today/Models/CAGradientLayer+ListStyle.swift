//
//  CAGradientLayer+ListStyle.swift
//  Today
//
//  Created by 陈竹青 on 2023/6/29.
//

import Foundation
import UIKit

extension CAGradientLayer {
    static func gradientlayer(for style: ReminderListStyle, in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = colors(for: style)
        layer.frame = frame
        return layer
    }
    
    private static func colors(for style: ReminderListStyle) -> [CGColor]{
        let beginColor: UIColor
        let endColor: UIColor
        
        switch style{
        case .all:
            beginColor = .todayGradientAllBegin
            endColor = .todayGradientAllEnd
        case .future:
            beginColor = .todayGradientFutureBegin
            endColor = .todayGradientFutureEnd
        case .today:
            beginColor = .todayGradientTodayBegin
            endColor = .todayGradientTodayEnd
        }
        
        return [beginColor.cgColor, endColor.cgColor]
    }
}
