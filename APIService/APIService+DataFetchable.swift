//
//  APIService+DataFetchable.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import Alamofire
import RxSwift

extension Reactive where Base: DataFetchable
{
    func fetch(
        from path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil) -> Single<Data?>
    {
        let fullPath = base.rootURL.appendingPathComponent(path)
        
        return .create { observer in
            Alamofire
                .request(fullPath,
                         method: method,
                         parameters: parameters)
                .response { (response) in
                    if let error = response.error
                    {
                        observer(.error(error))
                    }
                    else
                    {
                        observer(.success(response.data))
                    } }
            return Disposables.create()
        }
    }
}
