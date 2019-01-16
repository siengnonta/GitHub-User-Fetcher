//
//  UserViewModel.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import Foundation

class UserViewModel
{
    private let user: User
    var isFavorite: Bool
    
    init(_ user: User)
    {
        self.user = user
        self.isFavorite = false
    }
}

extension UserViewModel
{
    var login: String { return user.login }
    var avatar: URL { return user.avatar_url }
    var type: String { return user.type }
    var url: URL { return user.html_url }
    
    var formattedSiteAdmin: String
    {
        let status = user.site_admin ? "YES" : "NO"
        
        return "Site Admin : \(status)"
    }
}
