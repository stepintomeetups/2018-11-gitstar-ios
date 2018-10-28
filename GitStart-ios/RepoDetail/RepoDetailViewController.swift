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
        
        MBProgressHUD.showAdded(to: AppDelegate.shared.window!, animated: true)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        self.registerNibs()
        self.bindRows()
        self.details.accept(repo!.toKeyValuePair())
        DataProvider.shared.isRepoStarred(fullName: repo!.fullName!).subscribe(onNext:{ starred in
            self.isRepoStarred.accept(starred)
            MBProgressHUD.hide(for: AppDelegate.shared.window!, animated: true)
        }).disposed(by: disposeBag)
        self.isRepoStarred.subscribe(onNext: { starred in
            self.setStarButton(starred)
        }).disposed(by: disposeBag)
    }
    
    func setStarButton(_ starred: Bool) {
        var starImage = UIImage(named: "star")
        if starred {
            starImage = UIImage(named: "star_filled")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(starButtonPushed))
    }
    
    func registerNibs() {
        let repoDetailCellNib = UINib(nibName: Constants.Cells.RepoDetailCell, bundle: nil)
        self.tableView.register(repoDetailCellNib, forCellReuseIdentifier: Constants.Cells.RepoDetailCell)
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
    
    func bindRows(){
        self.details.bind(to: self.tableView.rx.items(cellIdentifier: Constants.Cells.RepoDetailCell)){ (_, model, cell: RepoDetailCell) in
            cell.keyLabel.text = model.0
            cell.valueLabel.text = model.1
        }.disposed(by: disposeBag)
    }
}

extension Repo {
    
    func toKeyValuePair() -> [KeyValuePair] {
        var pairs = [KeyValuePair]()
        
        pairs.append(("Name: ", self.name))
        pairs.append(("Description: ", self.description))
        pairs.append(("Forks: ", "\(self.forks ?? 0)"))
        pairs.append(("Watchers: ", "\(self.watchers ?? 0)"))
        
        return pairs
        
    }
    
}
