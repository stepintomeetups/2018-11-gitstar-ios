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
    var stars: Int?
    var language: String?
    
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
        stars <- map["stargazers_count"]
        language <- map["language"]
    }
    
}

extension Repo {
    
    func toKeyValuePair() -> [KeyValuePair] {
        var pairs = [KeyValuePair]()
        
        pairs.append(("Name: ", self.name))
        pairs.append(("Description: ", self.description))
        pairs.append(("Forks: ", "\(self.forks ?? 0)"))
        pairs.append(("Stars: ", "\(self.stars ?? 0)"))
        pairs.append(("Language: ", "\(self.language ?? "")"))
        
        return pairs
        
    }
    
}


