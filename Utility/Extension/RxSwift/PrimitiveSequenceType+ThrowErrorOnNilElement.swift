//
//  PrimitiveSequenceType+ThrowErrorOnNilElement.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import RxSwift

extension PrimitiveSequenceType where Self.TraitType == SingleTrait, ElementType: OptionalType
{
    func throwErrorOnNilElement() -> Single<ElementType.Wrapped>
    {
        return map { element -> ElementType.Wrapped in
            guard let value = element.optional else
            {
                throw JSONError.nilValue
            }
            
            return value }
    }
}
