//
//  UsersTableViewController.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import RxSwift
import UIKit

class UsersTableViewController: UITableViewController {
    
    // MARK: - Presenter
    
    let presenter = UsersPresenter()
    
    // MARK: - Dispose Bag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View's Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableViewConfiguration()
        cellRegistration()
        refreshControlConfiguration()
        dataBinding()
    }
    
    // MARK: -
    
    private func tableViewConfiguration()
    {
        tableView?.tableFooterView = UIView()
        tableView?.rowHeight = UITableView.automaticDimension
    }
    
    private func cellRegistration()
    {
        tableView?.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
    }
    
    private func refreshControlConfiguration()
    {
        let refreshControl = UIRefreshControl()
        
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .flatMap { [unowned self] in
                self.presenter.reloadData() }
            .subscribe(onNext: { [weak refreshControl] _ in
                refreshControl?.endRefreshing() })
            .disposed(by: disposeBag)
        
        tableView?.refreshControl = refreshControl
    }
    
    private func dataBinding()
    {
        presenter
            .reloadData()
            .subscribe({ [weak self] _ in
                self?.tableView?.reloadData() })
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .isBottomReached
            .filter { $0 }
            .flatMap { _ in
                self.presenter.loadData() }
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData() })
            .disposed(by: disposeBag)
    }
}

extension UsersTableViewController
{
    // MARK: -
    
    func favorited(at index: Int, with status: Bool)
    {
        presenter.updateFavorited(at: index, with: status)
        
        tableView?.reloadRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
    }
    
    // MARK: - Navigation
    
    func navigateToWebView(with url: URL, title: String)
    {
        let profileWebViewController = ProfileWebViewController(url: url, title: title)
        
        navigationController?.pushViewController(profileWebViewController, animated: true)
    }
}
