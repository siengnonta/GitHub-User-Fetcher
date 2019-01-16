//
//  ObservableType+FilterNil.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import RxSwift

extension ObservableType where E: OptionalType
{
    func filterNil() -> Observable<E.Wrapped>
    {
        return flatMap { element -> Observable<E.Wrapped> in
            guard let value = element.optional else
            {
                return .empty()
            }
            
            return .just(value) }
    }
}
