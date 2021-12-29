//
//  HTViewProtocl.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/24.
//

import Foundation
import UIKit

 protocol HTCellViewProtocol {
    func setModel(model: HTCellBaseModelProtocl) ->Void
    func sizeForcell(model: HTCellBaseModelProtocl, reuserIdentifer : String, indexPath : IndexPath) -> CGSize
    func heightForCell(model: HTCellBaseModelProtocl, reuserIdentifer: String, indexPatch: IndexPath) -> CGFloat
    func didSelectedAt(indexPath: IndexPath)->Void
}

protocol HTHeaderFooterViewProtocol {
    func setModel(model: HTHeaderFooterModelProtocol) -> Void
    func sizeForheaderFooterView(modle: HTHeaderFooterModelProtocol, reuserIdentifer: String, section: Int) -> CGSize
    func heightForHeaderFooterView(model: HTHeaderFooterModelProtocol, reuserIndeitfer: String, section: Int) -> CGFloat
}

extension HTHeaderFooterViewProtocol {
    func setModel(model: HTHeaderFooterModelProtocol) -> Void {
        
    }
    func sizeForheaderFooterView(modle: HTHeaderFooterModelProtocol, reuserIdentifer: String, section: Int) -> CGSize{
        return CGSize.zero
    }
    func heightForHeaderFooterView(model: HTHeaderFooterModelProtocol, reuserIndeitfer: String, section: Int) -> CGFloat {
        return 0.001
    }
}


extension HTCellViewProtocol{
    func sizeForcell(model: HTCellBaseModelProtocl, reuserIdentifer: String, indexPath: IndexPath) -> CGSize {
        return CGSize.zero
    }
    func heightForCell(model: HTCellBaseModelProtocl, reuserIdentifer: String, indexPatch: IndexPath) -> CGFloat {
        return 0
    }
    func setModel(model: HTCellBaseModelProtocl) {
        print("===")
    }
    func didSelectedAt(indexPath: IndexPath) {
    }
}

