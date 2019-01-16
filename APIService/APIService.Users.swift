//
//  APIService.Users.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import RxSwift

extension APIService
{
    class Users: APIDecodable, DataFetchable
    {
        let rootURL: URL
        
        required init(rootURL: URL)
        {
            self.rootURL = rootURL
        }
    }
}

extension Reactive where Base: APIService.Users
{
    func list() -> Single<[User]>
    {
        return fetch(from: .default,
                     method: .get)
            .decodeJSON([User].self)
            .throwErrorOnNilElement()
    }
}

extension APIService.Users: ReactiveCompatible { }

fileprivate typealias Path = String
fileprivate extension Path
{
    static var `default`: String { return "/users" }
}
