//
//  MoveSelectController.swift
//  电影院选座Demo
//
//  Created by 陈竹青 on 2021/7/8.
//

import UIKit
import HandyJSON

class MoveSelectController: UIViewController {
//    lazy var selectSeatView: HTSelectView = { [unowned self] in
//        let view = HTSelectView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 400), seatsArray: [], hallName: "") { (btn, dic) in
//            print("")
//        }
//
//        return view
//    }()
    var seletctSeatView : HTSelectView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        // Do any additional setup after loading the view.
        
        let path  = Bundle.main.path(forResource: "seats 0.plist", ofType: nil)
        let seatDic = NSDictionary.init(contentsOfFile: path!)
        
        let array: NSArray = seatDic?["seats"] as! NSArray
        var seatArray : [HTSeatsModel] = []
        array.enumerateObjects { (obj, index, roop) in
            let seatModel = HTSeatsModel.deserialize(from: obj as? Dictionary)
            seatArray.append(seatModel!)
        }
        let selectView = HTSelectView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 400), seatsArray: seatArray, hallName: "") { (btn, dic) in
            
        }
        self.seletctSeatView = selectView
        self.view.addSubview(selectView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
