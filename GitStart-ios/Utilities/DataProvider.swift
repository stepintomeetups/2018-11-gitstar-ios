//
//  DataProvider.swift
//  GitStart-ios
//
//  Created by Zsolt Pete on 2018. 10. 28..
//  Copyright © 2018. Zsolt Pete. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON
import ObjectMapper

class DataProvider: DataProviderProtocol {
    
    static let shared = DataProvider()
    
    static var headers: [String: String] {
        get {
            return [
                "Authorization": "token 00eef5f640a08474644a32cf2571f79c0adfeb1a",
                "Content-Length": "0"
            ]
        }
    }
    
    func getRepositories() -> Observable<[Repo]> {
        return Observable.create { observer in
            let url = Constants.EndPoints.GetRepos.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            Alamofire.request(url!, method: .get, headers: DataProvider.headers).responseArray(completionHandler: {  (response: DataResponse<[Repo]>) in
                if response.result.isSuccess {
                    let result = response.result.value!
                    observer.on(.next(result))
                    observer.on(.completed)
                }
            })
            return Disposables.create()
        }
    }
    
    func searchRepos(with name: String) -> Observable<[Repo]> {
        return Observable.create { observer in
            let url = (Constants.EndPoints.SearchRepos + "?q=" +  name).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            Alamofire.request(url!, method: .get, headers: DataProvider.headers).responseObject(completionHandler: {  (response: DataResponse<SearchRepoResponse>) in
                if response.result.isSuccess {
                    let result = response.result.value!
                    let repos = result.items ?? []
                    observer.on(.next(repos))
                    observer.on(.completed)
                }
            })
            return Disposables.create()
        }
    }
    
    func isRepoStarred(fullName: String) -> Observable<Bool> {
        return Observable.create { observer in
            let url = (Constants.EndPoints.StarRepo + fullName).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            Alamofire.request(url!, method: .get, headers: DataProvider.headers).responseObject(completionHandler: {  (response: DataResponse<BaseResponse>) in
                var result = false
                if response.response!.statusCode == 204 {
                    result = true
                } else if response.response!.statusCode == 404 {
                    result = false
                } else {
                    //TODO: Handle error
                }
                observer.on(.next(result))
                observer.on(.completed)
            })
            return Disposables.create()
        }
    }
    
    func starRepo(fullName: String) -> Observable<Bool> {
        return Observable.create { observer in
            let url = (Constants.EndPoints.StarRepo + fullName).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            Alamofire.request(url!, method: .put, headers: DataProvider.headers).responseObject(completionHandler: {  (response: DataResponse<BaseResponse>) in
                var result = false
                if response.response!.statusCode == 204 {
                    result = true
                } else {
                    //TODO: Handle error
                }
                observer.on(.next(result))
                observer.on(.completed)
            })
            return Disposables.create()
        }
    }
    
    func unStarRepo(fullName: String) -> Observable<Bool> {
        return Observable.create { observer in
            let url = (Constants.EndPoints.StarRepo + fullName).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            Alamofire.request(url!, method: .delete, headers: DataProvider.headers).responseObject(completionHandler: {  (response: DataResponse<BaseResponse>) in
                var result = false
                if response.response!.statusCode == 204 {
                    result = true
                } else {
                    //TODO: Handle error
                }
                observer.on(.next(result))
                observer.on(.completed)
            })
            return Disposables.create()
        }
    }
    
}
