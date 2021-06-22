//
//  APIProvider.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/14.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

// 首页接口
let APIProvider = MoyaProvider<API>()


enum API {
    case gameList(parameters:[String:Any]) //游戏列表
    case upComingList(parameters:[String:Any]) //即将上线列表
    case rankingList(parameters:[String:Any]) //排行榜
}


// 遵循 TargetType 代理 实现方法
extension API: TargetType {
    //服务器地址
    public var baseURL: URL {
         return URL(string: "https://www.taptap.com/webapiv2")!
    }

    var path: String {
        switch self {
//            case .homeGoodsList: return "wxmini/homePageContent"
//            case .homePageBelowConten: return "wxmini/homePageBelowConten"
//            case .goodDetail: return "wxmini/getGoodDetailById"
//            case .goodCategory: return "wxmini/getCategory"
//            case .categoryGoodsList: return "wxmini/getMallGoods"
        case .gameList:
            return "/landing/v5/timeline-with-guest"
        case .upComingList:
            return "/upcoming/v1/list"
        case .rankingList:
            return "/app-top/v1/hits"
        }
        
        
        
    }

    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .gameList(let parameters):
            parmeters = parameters
        case .upComingList(let parameters):
            parmeters = parameters
        case .rankingList(let parameters):
            parmeters = parameters
        }
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data {
        
        return "".data(using: String.Encoding.utf8)!
        
    }
    var headers: [String : String]? {
        return ["X-XSRF-TOKEN" : "eyJpdiI6IldmS2Rqak1tWWI4Q1JpaGR4ZTFXNlE9PSIsInZhbHVlIjoiRjcyN3RDcitpWWNrbFRxMFRkQ01uXC9SK1NIN0xJdXFcL21HU0F0Tkh4NFRnbDl0bWdxK3o1emVZRFBQbCtlOXRvSWhsY1U0ODVKRkhSa3hHTFJKMEJcL0E9PSIsIm1hYyI6Ijk2NjgxZDAxZWM3NWM2ZmRiMTIwZWNhNzgwNGM4MmZjMDIxNzg1NWFlMmZlYTU5ZDkxM2E5YmFjYzAwMWNhNjgifQ"]
    }
    
}


