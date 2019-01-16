//
//  APIDecodable.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import Foundation

protocol APIDecodable
{
    var rootURL: URL { get }
    
    init(rootURL: URL)
}
