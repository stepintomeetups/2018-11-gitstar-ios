//
//  Constants.swift
//  GitStart-ios
//
//  Created by Zsolt Pete on 2018. 10. 28..
//  Copyright © 2018. Zsolt Pete. All rights reserved.
//

import Foundation

struct Constants {
    
    struct EndPoints {
        static let Base = "https://api.github.com/"
        static let GetRepos = Base + "user/repos"
        static let SearchRepos = Base + "search/repositories"
        static let StarRepo = Base + "user/starred/"
    }
    
    struct Cells {
        static let SimpleRepoCell = "SimpleRepoCell"
        static let RepoDetailCell = "RepoDetailCell"
    }
    
    struct Segues {
        static let ShowRepoDetails = "ShowRepoDetails"
    }
    
}
