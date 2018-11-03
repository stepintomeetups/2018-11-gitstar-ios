//
//  RepoListViewController.swift
//  GitStart-ios
//
//  Created by Zsolt Pete on 2018. 10. 28..
//  Copyright © 2018. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

class RepoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My repos"
        MBProgressHUD.showAdded(to: AppDelegate.shared.window!, animated: true)
        self.registerNibs()
        self.bindRows()
        self.selectRow()
        self.tableView.rowHeight = 60
        DataProvider.shared.getRepositories().subscribe(onNext: { repos in
            DataStore.shared.repos.accept(repos)
            MBProgressHUD.hide(for: AppDelegate.shared.window!, animated: true)
        }).disposed(by: disposeBag)
    }
    
    func registerNibs() {
        let simpleRepoCellNib = UINib(nibName: Constants.Cells.SimpleRepoCell, bundle: nil)
        self.tableView.register(simpleRepoCellNib, forCellReuseIdentifier: Constants.Cells.SimpleRepoCell)
        
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

extension RepoListViewController {
    
    func bindRows(){
        DataStore.shared.repos.bind(to: self.tableView.rx.items(cellIdentifier: Constants.Cells.SimpleRepoCell)){
            (_, model, cell: SimpleRepoCell) in
            cell.nameLabel.text = model.name
            //            cell.ownerLabel.text = model.name
            }.disposed(by: disposeBag)
    }
    
    func selectRow(){
        self.tableView.rx.modelSelected(Repo.self).subscribe(onNext: { repo in
            self.performSegue(withIdentifier: Constants.Segues.ShowRepoDetails, sender: repo)
        }).disposed(by: disposeBag)
    }
    
}
