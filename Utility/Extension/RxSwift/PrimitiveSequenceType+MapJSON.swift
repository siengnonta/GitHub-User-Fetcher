//
//  PrimitiveSequenceType+MapJSON.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import RxSwift

extension PrimitiveSequenceType where Self.TraitType == SingleTrait, ElementType == Optional<Data>
{
    func decodeJSON<T: Decodable>(_ objectType: T.Type) -> Single<T?>
    {
        return map { data -> T? in
            guard let data = data else
            {
                return nil
            }
            
            do
            {
                return try JSONDecoder().decode(objectType, from: data)
            }
            catch
            {
                print(error)
                
                throw JSONError.invalidFormat
            }
        }
    }
}
