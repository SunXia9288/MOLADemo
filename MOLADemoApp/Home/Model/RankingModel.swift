//
//  RankingModel.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/22.
//

import UIKit
import HandyJSON

struct RankingBaseModel: HandyJSON {
    var list: [GameModel]?
    var next_page: String?
    var total: Int = -1
}

//struct RankingModel: HandyJSON {
//    var id: Int = -1
//    var title: String = ""
//    var icon: ImageModel?
//    var stat: StatModel?
//    var tags: [TagsModel]?
//    var author: String = ""
//    var uri: UriModel?
//
//}
