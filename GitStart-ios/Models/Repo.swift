//
//  Repo.swift
//  GitStart-ios
//
//  Created by Zsolt Pete on 2018. 10. 28..
//  Copyright © 2018. Zsolt Pete. All rights reserved.
//

import Foundation
import ObjectMapper

class Repo: BaseResponse {
    
    var name: String?
    var fullName: String?
    var description: String?
    var forks: Int?
    var watchers: Int?
    
    required init?(map: Map){
        super.init(map: map)
    }
    
    override init?(){
        super.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        fullName <- map["full_name"]
        description <- map["description"]
        forks <- map["forks"]
        watchers <- map["watchers"]
    }
    
}

