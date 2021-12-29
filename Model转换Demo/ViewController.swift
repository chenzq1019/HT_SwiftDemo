//
//  ViewController.swift
//  Model转换Demo
//
//  Created by 陈竹青 on 2021/9/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let person = Person()
        var count : UInt32 = 0
        let provertys = class_copyPropertyList(Person.classForCoder(), &count)
        print(provertys)
        
        for i in 0...(count-1) {
            var pro : objc_property_t = provertys![Int(i)]
            var proName : String = String(utf8String: property_getName(pro))!
            print(proName)
        }
        let dic = ["name":"weiwei","age":"18","education":"Master"]
        person.setValuesForKeys(dic)
        print(person)
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: person, requiringSecureCoding: false)
            UserDefaults.standard.setValue(data, forKey: "person")
            UserDefaults.standard.synchronize()
            

            
        }catch{
            print("保存归档失败")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        do{
//            let personData = UserDefaults.standard.value(forKey: "person") as! Data
//            let readPerson = try NSKeyedUnarchiver.unarchivedObject(ofClass: Person.self, from: personData )
//            print(readPerson as Any)
//        }catch{
//            print("读取归档失败")
//        }
        do{
            let personData = UserDefaults.standard.value(forKey: "person") as! Data
            let readPerson = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(personData)
            print(readPerson as! Person)
        }catch{
            print("读取归档失败")
        }
    }


}

