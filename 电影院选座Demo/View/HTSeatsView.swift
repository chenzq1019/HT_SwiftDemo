//
//  HTSeatsView.swift
//  电影院选座Demo
//
//  Created by 陈竹青 on 2021/7/8.
//

import UIKit
let SeatRowMargin : Float = 40
let SeatMinW_H : Float = 10


class HTSeatsView: UIView {
    
    var selectAction : ((_ seatBtn: HTSeatButton) -> Void)?
    var seatBtnHeight : Float = 0
    var seatBtnWidth : Float = 0
    var seatViewWidth : Float = 0
    var seatViewHeight : Float = 0

    init(frame: CGRect,seatArray:[HTSeatsModel], maxWidth: Float , actionBlock:@escaping (_ seatBtn: HTSeatButton) -> Void) {
        super.init(frame: frame)
        selectAction = actionBlock
        let seatsModel : HTSeatsModel? = seatArray.first
        var columnCount: Int = seatsModel?.columns?.count ?? 0
        if ((columnCount % 2) != 0) {
            columnCount += 1
        }
        
        var seatViewWidth = maxWidth - 2 * SeatRowMargin
        var seatBtnW = seatViewWidth / Float(columnCount)
        
        if seatBtnW > SeatMinW_H {
            seatBtnW = SeatMinW_H
            seatViewWidth = Float(columnCount) * SeatMinW_H
        }
        self.seatBtnWidth = seatBtnW
        self.seatBtnHeight = seatBtnW
        self.seatViewWidth = seatViewWidth
        self.seatViewHeight = seatBtnW * Float(seatArray.count)
        loadSeatBtns(seatsArray: seatArray)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSeatBtns(seatsArray:[HTSeatsModel]) -> Void {
        var seatIndex = 0
        for seatsModel in seatsArray {
            for i in 0 ..< (seatsModel.columns?.count ?? 0) {
                seatIndex += 1
                let seatModel = seatsModel.columns?[i]
                let seatBtn = HTSeatButton(type: .custom)
                seatBtn.seatmodel = seatModel
                seatBtn.seatsmodel = seatsModel
                if let model = seatModel {
                    if model.st == "N"{
                        seatBtn.setImage(UIImage(named: "choosable"), for: .normal)
                        seatBtn.setImage(UIImage(named: "selected"), for: .selected)
                        seatBtn.setImage(UIImage(named: "selected"), for: .highlighted)
                        seatBtn.seatIndex = seatIndex
                    }else if model.st == "E" {
                        continue
                    }else{
                        seatBtn.setImage(UIImage(named: "sold"), for: .normal)
                        seatBtn.isUserInteractionEnabled = false
                    }
                }
                seatBtn.addTarget(self, action: #selector(seatBtnAction(sender:)), for: .touchUpInside)
                self.addSubview(seatBtn)
                
            }
        }
    }
    
    @objc func seatBtnAction(sender: UIButton) -> Void{
        sender.isSelected = !sender.isSelected
    }
    
}

extension HTSeatsView {
    override func layoutSubviews() {
        super.layoutSubviews()
        for view in self.subviews {
            if view.isKind(of: HTSeatButton.self) {
                let seatBtn = view as! HTSeatButton
                
                if let array = seatBtn.seatsmodel?.columns ,let seatsModel = seatBtn.seatsmodel{
                    let col = array.firstIndex(where: {(model) -> Bool in
                        return  model.columnId == seatBtn.seatmodel?.columnId
                                                })
                    let row = seatsModel.rowNum
                    
                    if let l = col, let r = row {
                        let r1 = r - 1
                        seatBtn.frame = CGRect(x: CGFloat(Float(l) * self.seatBtnWidth), y: CGFloat(Float(r1) * self.seatBtnHeight), width: CGFloat( self.seatBtnWidth) , height: CGFloat(self.seatBtnWidth))
                    }
      
                }
               
            }
        }
    }
}
