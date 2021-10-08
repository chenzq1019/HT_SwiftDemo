//
//  ViewController.swift
//  MoyaDemo
//
//  Created by 陈竹青 on 2021/9/1.
//

import UIKit
import Moya
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let provider = MoyaProvider<HomePageService>(endpointClosure: endpointClosure)
        provider.request(.bannerInfo) { (result) in
            switch result{
            case let .success(response):
                let jsonDic = try! response.mapJSON() as? NSDictionary
                print(jsonDic!)
                break
            case let .failure(error):
                print(error)
                break
            }
        }
        provider.request(.listInfo) { (result) in
            switch result {
            case let .success(response):
                let jsonDic = try! response.mapJSON() as? NSDictionary
                print(jsonDic!)
                break
            case let .failure(error):
                print(error)
                break
            }
        }
      
    }
}

