//
//  RecommentGameModel.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/16.
//

import HandyJSON
import UIKit

struct RecommentBaseModel: HandyJSON {
    var list: [RecommentGameModel]?
    var next_page: String?
}

// 游戏信息
struct RecommentGameModel: HandyJSON {
    var image: ImageModel?
    var via: String = ""
    var title: String = ""
    var contents: String = ""
    var web_url: String = ""
    var icon: ImageModel?
    var category: String = ""
    var app_summary: GameModel?
    var tags: [TagsModel]?
    var uri: UriModel?
    var rating: RatingModel?
}
