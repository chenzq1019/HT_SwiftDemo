//
//  HotBox.swift
//  CodebleDemo
//
//  Created by 陈竹青 on 2023/7/4.
//

import Foundation


let hotBoxJson: String = """
{
 "name": "chenzq",
 "age": 18,
 "height": 1.85,
}
"""


struct HotBox: Codable{
    
    var name: String
    var age: Int
    var height: Double
    
}
