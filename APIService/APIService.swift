//
//  APIService.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import Foundation

class APIService
{
    static let shared = APIService()
    
    let userService: APIService.Users
    
    private init()
    {
        guard let rootURL = URL(string: "https://api.github.com") else
        {
            fatalError("Invalid url path")
        }
        
        userService = Users(rootURL: rootURL)
    }
}
