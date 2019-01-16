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
    func list(page: Int, limit: Int = 30) -> Single<[User]>
    {
        let parameters: [String: Any] = [ .page: page,
                                          .limit: limit ]
        
        return fetch(from: .default,
                     method: .get,
                     parameters: parameters)
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

fileprivate typealias Parameter = String
fileprivate extension Parameter
{
    static var page: String { return "page" }
    static var limit: String { return "limit" }
}
