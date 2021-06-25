//
//  APIProvider.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/14.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import Foundation
import HandyJSON
import Moya

// 首页接口
let APIProvider = MoyaProvider<API>()

enum API {
    case gameList(parameters: [String: Any]) // 游戏列表
    case upComingList(parameters: [String: Any]) // 即将上线列表
    case rankingList(parameters: [String: Any]) // 排行榜
    case gameInfo(parameters: [String: Any]) // 游戏信息
    case gameFeedListInfo(parameters: [String: Any]) // 游戏-动态列表
}

// 遵循 TargetType 代理 实现方法
extension API: TargetType {
    // 服务器地址
    public var baseURL: URL {
        switch self {
        case .gameFeedListInfo:
            return URL(string: "https://api.taptapdada.com/")!
        default:
            return URL(string: "https://www.taptap.com/webapiv2")!
        }
    }

    var path: String {
        switch self {
        case .gameList:
            return "/landing/v5/timeline-with-guest"
        case .upComingList:
            return "/upcoming/v1/list"
        case .rankingList:
            return "/app-top/v1/hits"
        case .gameInfo:
            return "/group/v1/detail"
        case .gameFeedListInfo:
            return "/feed/v2/by-app"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        var parmeters: [String: Any] = [:]
        switch self {
        case let .gameList(parameters):
            parmeters = parameters
        case let .upComingList(parameters):
            parmeters = parameters
        case let .rankingList(parameters):
            parmeters = parameters
        case let .gameInfo(parameters):
            parmeters = parameters
        case let .gameFeedListInfo(parameters):
            parmeters = parameters
        }

        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    var headers: [String: String]? {
        return ["X-XSRF-TOKEN": "eyJpdiI6IldmS2Rqak1tWWI4Q1JpaGR4ZTFXNlE9PSIsInZhbHVlIjoiRjcyN3RDcitpWWNrbFRxMFRkQ01uXC9SK1NIN0xJdXFcL21HU0F0Tkh4NFRnbDl0bWdxK3o1emVZRFBQbCtlOXRvSWhsY1U0ODVKRkhSa3hHTFJKMEJcL0E9PSIsIm1hYyI6Ijk2NjgxZDAxZWM3NWM2ZmRiMTIwZWNhNzgwNGM4MmZjMDIxNzg1NWFlMmZlYTU5ZDkxM2E5YmFjYzAwMWNhNjgifQ"]
    }
}
