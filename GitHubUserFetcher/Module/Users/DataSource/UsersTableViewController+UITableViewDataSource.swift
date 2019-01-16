//
//  UsersTableViewController+DataSource.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import UIKit

extension UsersTableViewController
{
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return presenter.userViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell else
        {
            fatalError("Invalid cell identifier")
        }
        
        let userViewModel = presenter.userViewModels[indexPath.row]
        
        cell.avatar = userViewModel.avatar
        cell.login = userViewModel.login
        cell.type = userViewModel.type
        cell.github = userViewModel.url.absoluteString
        cell.adminStatus = userViewModel.formattedSiteAdmin
        cell.isFavorited = userViewModel.isFavorite
        
        cell
            .rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.favorited(at: indexPath.row, with: $0) })
            .disposed(by: cell.reusableDisposeBag)
        
        return cell
    }
}
