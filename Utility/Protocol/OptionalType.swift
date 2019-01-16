//
//  OptionalType.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import Foundation

protocol OptionalType
{
    associatedtype Wrapped
    
    var optional: Wrapped? { get }
}

extension Optional: OptionalType
{
    public var optional: Wrapped? { return self }
}
