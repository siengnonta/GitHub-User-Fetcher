//
//  User.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import Foundation

struct User: Codable
{
    let login: String
    let id: Int
    let avatar_url: URL
    let url: URL
    let site_admin: Bool
}
