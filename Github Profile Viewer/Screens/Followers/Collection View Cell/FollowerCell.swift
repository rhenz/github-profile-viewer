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
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
