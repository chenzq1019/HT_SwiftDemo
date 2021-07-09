//
//  HTSeatsModel.swift
//  电影院选座Demo
//
//  Created by 陈竹青 on 2021/7/8.
//

import UIKit
import HandyJSON

struct HTSeatsModel: HandyJSON {
    
    var rowId : String?
    var rowNum : Int?
    var columns : Array<HTSeatModel>?
}


struct HTSeatModel: HandyJSON {
    var columnId : String?
    var seatNo: String?
    var st: String?
}
