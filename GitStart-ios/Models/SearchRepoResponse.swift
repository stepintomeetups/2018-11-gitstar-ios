//
//  SearchRepoResponse.swift
//  GitStart-ios
//
//  Created by Zsolt Pete on 2018. 10. 28..
//  Copyright © 2018. Zsolt Pete. All rights reserved.
//

import Foundation
import ObjectMapper

class  SearchRepoResponse: BaseResponse {
    var items: [Repo]?
    
    required init?(map: Map){
        super.init(map: map)
    }
    
    override init?(){
        super.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        items <- map["items"]
    }
}
