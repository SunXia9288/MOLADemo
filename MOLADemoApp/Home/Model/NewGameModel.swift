//
//  NewGameModel.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/22.
//

import Foundation
import HandyJSON

struct NewGameBaseModel: HandyJSON {
    var list: [NewGameModel]?
    var prev_page: String?
    var next_page: String?
}

struct NewGameModel: HandyJSON {
    var id: Int = -1
    var type_label: String = ""
    var image: ImageModel?
    var rec_text: String = ""
    var app: GameModel?
    var event_at: Int = -1
}
