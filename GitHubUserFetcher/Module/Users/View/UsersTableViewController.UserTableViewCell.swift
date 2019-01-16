//
//  UsersTableViewController.UserTableViewCell.swift
//  GitHubUserFetcher
//
//  Created by Nontapat  Siengsanor on 16/1/19.
//  Copyright © 2019 Nontapat Siengsanor. All rights reserved.
//

import Alamofire
import AlamofireImage
import RxSwift
import RxCocoa
import SnapKit
import UIKit

extension UsersTableViewController
{
    class UserTableViewCell: UITableViewCell
    {
        // MARK: - Variables
        
        var avatar: URL? { didSet { didSetAvatar() } }
        
        var login: String? {
            get { return loginLabel.text }
            set { loginLabel.text = newValue } }
        
        var github: String? {
            get { return githubLabel.text }
            set { githubLabel.text = newValue } }
        
        var type: String? {
            get { return accountTypeLabel.text }
            set { accountTypeLabel.text = newValue } }
        
        var adminStatus: String? {
            get { return statusLabel.text }
            set { statusLabel.text = newValue } }
        
        var isFavorited: Bool {
            get { return favoriteButton.isSelected }
            set { favoriteButton.isSelected = newValue } }
        
        // MARK: - Subviews
        
        private let avatarImageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            
            return imageView }()
        
        private let loginLabel: UILabel = {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
            
            return label }()
        
        private let githubLabel: UILabel = {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.callout)
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5
            
            return label }()
        
        private let accountTypeLabel: UILabel = {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
            
            return label }()
        
        private let statusLabel: UILabel = {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
            
            return label }()
        
        fileprivate let favoriteButton: UIButton = {
            let buttton = UIButton(type: .roundedRect)
            buttton.translatesAutoresizingMaskIntoConstraints = false
            buttton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
            buttton.setTitle("Not Favorited", for: .normal)
            buttton.setTitle("Favorited", for: .selected)
            
            return buttton }()
        
        // MARK: - Dispose Bag
        
        private(set) var reusableDisposeBag = DisposeBag()
        
        // MARK: - Initializer
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
        {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            commonInit()
        }
        
        required init?(coder aDecoder: NSCoder)
        {
            super.init(coder: aDecoder)
            
            commonInit()
        }
        
        private func commonInit()
        {
            selectionStyle = .none
            
            contentView.addSubview(avatarImageView)
            contentView.addSubview(loginLabel)
            contentView.addSubview(githubLabel)
            contentView.addSubview(accountTypeLabel)
            contentView.addSubview(statusLabel)
            contentView.addSubview(favoriteButton)
            
            addViewConstraints()
        }
        
        // MARK: - Setter
        
        private func didSetAvatar()
        {
            guard let avatar = self.avatar else
            {
                return
            }
            
            Alamofire
                .request(avatar)
                .responseImage { [weak self] response in
                    self?.avatarImageView.image = response.result.value }
        }
        
        // MARK: -
        
        private func addViewConstraints()
        {
            avatarImageView.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(Spacing.intermediate)
                $0.centerY.equalToSuperview()
                $0.size.equalTo(36.0) }
            
            loginLabel.snp.makeConstraints {
                $0.leading.equalTo(avatarImageView.snp.trailing).offset(Spacing.intermediate)
                $0.trailing.lessThanOrEqualTo(favoriteButton.snp.leading).offset(-Spacing.minor)
                $0.top.equalToSuperview().offset(Spacing.minor) }
            
            githubLabel.snp.makeConstraints {
                $0.leading.equalTo(avatarImageView.snp.trailing).offset(Spacing.intermediate)
                $0.trailing.lessThanOrEqualTo(favoriteButton.snp.leading).offset(-Spacing.minor)
                $0.top.equalTo(loginLabel.snp.bottom).offset(Spacing.minor) }
            
            accountTypeLabel.snp.makeConstraints {
                $0.leading.equalTo(avatarImageView.snp.trailing).offset(Spacing.intermediate)
                $0.trailing.lessThanOrEqualTo(favoriteButton.snp.leading).offset(-Spacing.minor)
                $0.top.equalTo(githubLabel.snp.bottom).offset(Spacing.minor) }
            
            statusLabel.snp.makeConstraints {
                $0.leading.equalTo(avatarImageView.snp.trailing).offset(Spacing.intermediate)
                $0.trailing.lessThanOrEqualTo(favoriteButton.snp.leading).offset(-Spacing.minor)
                $0.top.equalTo(accountTypeLabel.snp.bottom).offset(Spacing.minor)
                $0.bottom.equalToSuperview().offset(-Spacing.intermediate) }
            
            favoriteButton.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().offset(-Spacing.intermediate) }
        }
        
        // MARK: -
        
        override func prepareForReuse()
        {
            avatarImageView.image = nil
            reusableDisposeBag = DisposeBag()
            favoriteButton.isSelected = false
        }
    }
}

extension Reactive where Base: UsersTableViewController.UserTableViewCell
{
    var tap: Observable<Bool>
    {
        return base
            .favoriteButton
            .rx
            .tap
            .map { !self.base.favoriteButton.isSelected }
    }
}

typealias Spacing = CGFloat
extension Spacing
{
    static var minor: CGFloat { return 8.0 }
    static var intermediate: CGFloat { return 16.0 }
    static var major: CGFloat { return 24.0 }
}
