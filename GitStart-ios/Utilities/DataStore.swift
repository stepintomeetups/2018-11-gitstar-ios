//
//  DataStore.swift
//  GitStart-ios
//
//  Created by Zsolt Pete on 2018. 10. 28..
//  Copyright © 2018. Zsolt Pete. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class DataStore {
    
    static let shared = DataStore()
    
    var repos = BehaviorRelay(value: [Repo]())
    var searchedRepos = BehaviorRelay(value: [Repo]())
    
}
