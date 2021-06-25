//
//  GameModel.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/22.
//

import Foundation
import HandyJSON

struct GameModel: HandyJSON {
    var id: Int = -1
    var title: String = ""
    var icon: ImageModel?
    var category: String = ""
    var uri: UriModel?
    var ad_banner: ImageModel?
    var banner: ImageModel?
    var tags: [TagsModel]?
    var stat: StatModel?
    var released_time: Int = -1
    var author: String = ""
}
