//
//  UsersPresenter.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import RxCocoa
import RxSwift

class UsersPresenter
{
    // MARK: - Variables
    
    private let userViewModelsBehaviorRelay = BehaviorRelay<[UserViewModel]>(value: [])
    var userViewModels: [UserViewModel] {
        get { return userViewModelsBehaviorRelay.value }
        set { userViewModelsBehaviorRelay.accept(newValue) } }
    
    // MARK: - Pagination
    
    private var page: Int = 0
    private let limit: Int = 30
    
    private var isLoading: Bool = false
    private var isLoadAll: Bool = false
}

extension UsersPresenter
{
    func reloadData() -> Observable<[UserViewModel]>
    {
        if isLoading
        {
            return .empty()
        }
        
        isLoading = true
        page = 0
        
        return APIService
            .shared
            .userService
            .rx
            .list(page: page,
                  limit: limit)
            .map { users in users.map(UserViewModel.init) }
            .do(onSuccess: { [weak self] _ in self?.isLoading = false },
                onError: { [weak self] _ in self?.isLoading = false })
            .do(onSuccess: { [weak self] in
                self?.isLoadAll = $0.count < (self?.limit ?? 30) })
            .do(onSuccess: { [weak self] in
                self?.userViewModelsBehaviorRelay.accept($0)
                self?.page += 1 })
            .asObservable()
    }
    
    func loadData() -> Observable<[UserViewModel]>
    {
        if isLoading
        {
            return .empty()
        }
        
        isLoading = true
        
        return APIService
            .shared
            .userService
            .rx
            .list(page: page,
                  limit: limit)
            .map { users in users.map(UserViewModel.init) }
            .do(onSuccess: { [weak self] _ in self?.isLoading = false },
                onError: { [weak self] _ in self?.isLoading = false })
            .do(onSuccess: { [weak self] in
                self?.isLoadAll = $0.count < (self?.limit ?? 30) })
            .do(onSuccess: { [unowned self] in
                self.userViewModelsBehaviorRelay.accept(self.userViewModels + $0)
                self.page += 1 })
            .asObservable()
    }
    
    func updateFavorited(at index: Int, with status: Bool)
    {
        guard 0..<userViewModels.count ~= index else { return }
        
        userViewModels[index].isFavorite = status
    }
}
