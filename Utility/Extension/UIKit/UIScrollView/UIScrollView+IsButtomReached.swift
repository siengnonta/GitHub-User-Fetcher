//
//  UIScrollView+IsButtomReached.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension UIScrollView
{
    var isBottomReached: Bool
    {
        return contentOffset.y + bounds.height >= contentSize.height + contentInset.bottom
    }
}

extension Reactive where Base: UIScrollView
{
    var isBottomReached: Observable<Bool>
    {
        return contentOffset
            .map { _ in self.base.isBottomReached }
            .distinctUntilChanged()
    }
}
