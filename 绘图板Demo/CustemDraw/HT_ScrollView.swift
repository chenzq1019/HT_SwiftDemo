//
//  HT_ScrollView.swift
//  绘图板Demo
//
//  Created by 陈竹青 on 2020/12/25.
//

import UIKit

class HT_ScrollView: UIScrollView {

    override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
        if event?.allTouches?.count == 1 {
            return true
        }
        return false
    }
}
