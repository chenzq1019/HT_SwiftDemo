//
//  HT_Drawer.swift
//  绘图板Demo
//
//  Created by 陈竹青 on 2020/12/25.
//

import UIKit

class HT_Drawer: UIView {

    var paint : HT_DrawPaint = {
        let paint = HT_DrawPaint(width: 4, color: UIColor.red)
        return paint
    }()
    var slayer : CAShapeLayer?
    var width : CGFloat = 3
    var lines : [CAShapeLayer] = []
    var cancelLines : [CAShapeLayer] = []
    var color : UIColor = UIColor.red
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//绘图过程
extension HT_Drawer{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let startP : CGPoint = (touches.randomElement()?.location(in: self))!
        if event?.allTouches?.count == 1 {
            let path = HT_DrawPaint(width: width, color: UIColor.red)
            path.move(to: startP)
            path.lineCapStyle = .round; //线条拐角
            path.lineJoinStyle = .round; //终点处理
//            path.lineWidth = self.width
            self.paint = path
            let slayer = CAShapeLayer()
            slayer.path = path.cgPath
            slayer.backgroundColor = UIColor.clear.cgColor
            slayer.fillColor = UIColor.clear.cgColor
            slayer.lineCap = .round
            slayer.lineJoin = .round
            slayer.strokeColor = self.color.cgColor
            slayer.lineWidth = self.width
            self.layer.addSublayer(slayer)
            self.slayer = slayer
            if let line = self.slayer {
                self.lines.append(line)
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let moveP : CGPoint = (touches.randomElement()?.location(in: self))!
        if (event?.allTouches!.count)! > 1 {
            superview?.touchesMoved(touches, with: event)
        }else if event?.allTouches?.count == 1 {
            paint.addLine(to: moveP)
            slayer?.path = paint.cgPath
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func drawLine() -> Void {
        if let line = self.lines.last {
            self.layer.addSublayer(line)
        }
        
    }
    
    func cleanScreen() -> Void {
        if self.lines.count > 0 {
            for layout in self.lines {
                layout.removeFromSuperlayer()
            }
            self.lines.removeAll()
        }
    }
    
    func undo() -> Void {
        if self.lines.count > 0, let line = self.lines.last {
            self.cancelLines.append(line)
            line.removeFromSuperlayer()
            self.lines.removeLast()
        }
    }
    
    func redo() -> Void {
        if self.cancelLines.count > 0 , let line = self.cancelLines.last {
            self.lines.append(line)
            drawLine()
            self.cancelLines.removeLast()
        }
    }
    func chooseNorml(width: CGFloat) -> Void {
        self.width = width
    }
    
    func chooseColor(color: UIColor) -> Void {
        self.color  = color
    }
    
    func erase() -> Void {
        self.color = UIColor.white
        self.width = 40
    }
}
