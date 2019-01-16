//
//  UsersTableViewController+UITableViewDelegate.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import UIKit

extension UsersTableViewController
{
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let url = presenter.userViewModels[indexPath.row].url
        let title = presenter.userViewModels[indexPath.row].login
        
        navigateToWebView(with: url, title: title)
    }
}
