//
//  HTSectionBaseModel.swift
//  HT_BaseObject
//
//  Created by 陈竹青 on 2021/12/24.
//

import Foundation
import UIKit

struct SectionBaseModel {
    var header : HTHeaderFooterModelProtocol?
    var footer : HTHeaderFooterModelProtocol?
    var identify: String?
    var groupId: Int?
    var groupSort: Int?
    var minimuLineSpacing: CGFloat = 0
    var minimuInteritemSpaceing: CGFloat = 0
    var inset: UIEdgeInsets = UIEdgeInsets.zero
    var cellArray: [HTCellBaseModelProtocl]? = [HTCellBaseModelProtocl]()
    var headHeight: CGFloat = 0.0001
    var footHeight: CGFloat = 0.0001
}
