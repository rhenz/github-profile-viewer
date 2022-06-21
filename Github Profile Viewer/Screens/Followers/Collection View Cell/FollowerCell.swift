//
//  FollowerCell.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/21/22.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    // MARK: -
    
    static let reuseIdentifier = "FollowerCell"
    
    let avatarImageView = GPVAvatarImageView(frame: .zero)
    let usernameLabel = GPVTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Methods
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            avatarImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            avatarImageView.trailingAnchor.constraint(equalToSystemSpacingAfter: contentView.trailingAnchor, multiplier: 1),
//            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
//            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
//            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            usernameLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: contentView.trailingAnchor, multiplier: 1),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
