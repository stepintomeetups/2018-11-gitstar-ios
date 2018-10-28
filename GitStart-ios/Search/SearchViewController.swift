//
//  SearchViewController.swift
//  GitStart-ios
//
//  Created by Zsolt Pete on 2018. 10. 28..
//  Copyright © 2018. Zsolt Pete. All rights reserved.
//

import MBProgressHUD
import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 60
        self.bindRows()
        self.selectRow()
        self.registerNibs()
        searchField.rx.text.throttle(1.0, scheduler: MainScheduler.instance).subscribe(onNext: { repoName in
            if let name = repoName, name.count > 2 {
                self.searchRepo(name: repoName!)
            } else {
                DataStore.shared.searchedRepos.accept([])
            }
            
        }).disposed(by: disposeBag)
    }
    
    func registerNibs() {
        let simpleRepoCellNib = UINib(nibName: Constants.Cells.SimpleRepoCell, bundle: nil)
        self.tableView.register(simpleRepoCellNib, forCellReuseIdentifier: Constants.Cells.SimpleRepoCell)
        
    }
    
    func searchRepo(name: String) {
        MBProgressHUD.showAdded(to: AppDelegate.shared.window!, animated: true)
        DataProvider.shared.searchRepos(with: name).subscribe(onNext: { repos in
            DataStore.shared.searchedRepos.accept(repos)
            MBProgressHUD.hide(for: AppDelegate.shared.window!, animated: true)
        }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let repo = sender as? Repo else {
            return
        }
        guard let repoDetailViewController = segue.destination as? RepoDetailViewController else {
            return
        }
        repoDetailViewController.repo = repo
    }
    
}

extension SearchViewController {
    
    func bindRows(){
        DataStore.shared.searchedRepos.bind(to: self.tableView.rx.items(cellIdentifier: Constants.Cells.SimpleRepoCell)){
            (_, model, cell: SimpleRepoCell) in
            cell.nameLabel.text = model.name
            cell.ownerLabel.text = model.fullName
            }.disposed(by: disposeBag)
    }
    
    func selectRow(){
        self.tableView.rx.modelSelected(Repo.self).subscribe(onNext: { repo in
            self.performSegue(withIdentifier: Constants.Segues.ShowRepoDetails, sender: repo)
        }).disposed(by: disposeBag)
    }
    
}
