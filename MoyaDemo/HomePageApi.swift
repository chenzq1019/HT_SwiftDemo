//
//  HomePageApi.swift
//  MoyaDemo
//
//  Created by 陈竹青 on 2021/9/2.
//

import Foundation
import Moya
import Alamofire


let endpointClosure = { (target: HomePageService) -> Endpoint in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    return  Endpoint(url: url, sampleResponseClosure: { .networkResponse(200, target.sampleData) }, method: target.method, task: target.task, httpHeaderFields: ["app_version":"4.7.1","version_no":"471","client_type":"ule","market_id":"015","appkey":"b9563a085baedf51","session_id":"","user_token":"",])
}

enum HomePageService {
    case bannerInfo
    case listInfo
    case middleModle(type: String)
}

extension HomePageService : TargetType {

    var baseURL: URL {
        return URL(string: "https://static-content.ulecdn.com")!
    }
    
    var path: String {
        switch self {
        case .bannerInfo:
            return "/mobilead/v2/recommend/queryAppRecBanner/310000/app"
        case .listInfo:
            return "/mobilead/v2/recommend/listingRecommentGet/app/ule_index_guess_like_310000/null/null/0.html"
        case .middleModle(_):
            return "/mobilead/v2/recommend/listingRecommentGet/app/"
        }
    }
    
    var method: Moya.Method {
    
        return .get
    }
    
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .bannerInfo:
//            params = ["phone":phoneNum,"password":pwd]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .listInfo:
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .middleModle(type: let type):
            params = ["middleType":type]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }

}
