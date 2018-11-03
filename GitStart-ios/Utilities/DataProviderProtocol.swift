//
//  DataProviderProtocol.swift
//  GitStart-ios
//
//  Created by Zsolt Pete on 2018. 10. 28..
//  Copyright © 2018. Zsolt Pete. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DataProviderProtocol {
    
    func getRepositories() -> Observable<[Repo]>
    func searchRepos(with name: String) -> Observable<[Repo]>
    func isRepoStarred(fullName: String) -> Observable<Bool>
    func starRepo(fullName: String) -> Observable<Bool>
    func unStarRepo(fullName: String) -> Observable<Bool>
    
}
