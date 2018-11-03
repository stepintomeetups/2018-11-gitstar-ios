//
//  RepoDetailViewController.swift
//  GitStart-ios
//
//  Created by Zsolt Pete on 2018. 10. 28..
//  Copyright © 2018. Zsolt Pete. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MBProgressHUD

typealias KeyValuePair = (String, String?)

class RepoDetailViewController: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var repo: Repo?
    var details = BehaviorRelay<[KeyValuePair]>(value: [])
    var isRepoStarred = BehaviorRelay(value: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Summary"
        MBProgressHUD.showAdded(to: AppDelegate.shared.window!, animated: true)
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        self.registerNibs()
        
        self.bindRows()
        self.checkIsStarred()
        
        self.details.accept(repo!.toKeyValuePair())
        
    }
    
    func checkIsStarred(){
        DataProvider.shared.isRepoStarred(fullName: repo!.fullName!).subscribe(onNext:{ starred in
            self.isRepoStarred.accept(starred)
            MBProgressHUD.hide(for: AppDelegate.shared.window!, animated: true)
        }).disposed(by: disposeBag)
        self.isRepoStarred.subscribe(onNext: { starred in
            self.setStarButton(starred)
        }).disposed(by: disposeBag)
    }
    
    func setStarButton(_ starred: Bool) {
        var starImage = Constants.Images.Star
        if starred {
            starImage = Constants.Images.StarFilled
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(starButtonPushed))
    }
    
    //TODO: Need implement register nib
    func registerNibs() {
        
    }
    
    @objc func starButtonPushed() {
        if self.isRepoStarred.value {
            DataProvider.shared.unStarRepo(fullName: repo!.fullName!).subscribe(onNext: { success in
                if success {
                    self.isRepoStarred.accept(false)
                }
            }).disposed(by: disposeBag)
        } else {
            DataProvider.shared.starRepo(fullName: repo!.fullName!).subscribe(onNext: { success in
                if success {
                    self.isRepoStarred.accept(true)
                }
            }).disposed(by: disposeBag)
        }
    }

}


extension RepoDetailViewController {
    
    //TODO: Need implement bind rows
    func bindRows(){
        
    }
}
