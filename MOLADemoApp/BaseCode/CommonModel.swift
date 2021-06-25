//
//  CommonModel.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/22.
//

import HandyJSON
import UIKit

// CommonModel
struct CommonModel: HandyJSON {}

// 图片model
struct ImageModel: HandyJSON {
    var url: String = ""
    var medium_url: String = ""
    var original_url: String = ""
    var width: CGFloat?
    var height: CGFloat?
    var color: String?
    var original_size: Int?
}

// 标签model
struct TagsModel: HandyJSON {
    var id: Int = -1
    var value: String = ""
    var uri: String = ""
}

// 跳转商店model
struct UriModel: HandyJSON {
    var apple: String?
    var google: String?
}

// 评分Model
struct StatModel: HandyJSON {
    var rating: RatingModel?
    var fans_count: Int = -1
    var play_count: Int = -1
    var download_count: Int = -1
    var pv_count = -1
    var video_count: Int = -1
    var album_count: Int = -1
    var feed_count: Int = -1
}

struct RatingModel: HandyJSON {
    var score: String = ""
    var max: Int = 10
}

// 用户model
struct UserModel: HandyJSON {
    var id: Int = -1
    var name: String = ""
    var avatar: String = ""
    var medium_avatar: String = ""
    var intro: String = ""
}

// label - Model 分类
struct LabelModel: HandyJSON {
    var name: String = ""
    var uri: String = ""
}
