//
//  Constants.swift
//  GitStart-ios
//
//  Created by Zsolt Pete on 2018. 10. 28..
//  Copyright © 2018. Zsolt Pete. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct EndPoints {
        static let Base = "https://api.github.com/"
        static let GetRepos = Base + "user/repos"
        static let SearchRepos = Base + "search/repositories"
        static let StarRepo = Base + "user/starred/"
    }
    
    struct Cells {
        static let SimpleRepoCell = "SimpleRepoCell"
    }
    
    struct Segues {
        static let ShowRepoDetails = "ShowRepoDetails"
    }
    
    struct Images {
        static let Star = UIImage(named: "star")!
        static let StarFilled = UIImage(named: "star_filled")!
    }
    
}
