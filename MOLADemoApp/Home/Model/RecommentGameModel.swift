//
//  RecommentGameModel.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/16.
//

import ObjectMapper

class RecommentGameModel: Mappable {
    var username: String?
    var age: Int?
    var weight: Double!
    var birthday: Date?
    var array: [AnyObject]?
    var dictionary: [String : AnyObject] = [:]
     
    init(){
        
    }
     
    required init?(map: Map) {
    }
     
    // Mappable
    func mapping(map: Map) {
        username    <- map["username"]
        age         <- map["age"]
        weight      <- map["weight"]
        birthday    <- (map["birthday"], DateTransform())
        array       <- map["arr"]
        dictionary  <- map["dict"]
    }
}
