//
//  GameFeedModel.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/24.
//

import Foundation
import HandyJSON


struct GameFeedBaseModel: HandyJSON {
    var list: [GameFeedShellModel]?
    var next_page: String?
    var total: Int = -1
}

struct GameFeedShellModel: HandyJSON {
    var data: GameFeedModel?
}

struct GameFeedModel: HandyJSON {
    var id: Int = -1
    var title: String = ""
    var summary: String = ""
    var author: UserModel?
    var images: [ImageModel]?
    var app: GameModel?
    var labels: [LabelModel]?
    var created_time: Int = -1
}
