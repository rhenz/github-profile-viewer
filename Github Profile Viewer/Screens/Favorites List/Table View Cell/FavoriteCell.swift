//
//  FavoriteCell.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/29/22.
//

import UIKit

class FavoriteCell: UITableViewCell {

    // MARK: - View Components
    
    let avatarImageView = GPVAvatarImageView(frame: .zero)
    let usernameLabel = GPVTitleLabel(textAlignment: .left, fontSize: 26)
    
    let dispatchQueue = DispatchQueue(label: "FavoriteCell Dispatch Queue")
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public API

extension FavoriteCell {
    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        
        dispatchQueue.async {
            self.avatarImageView.setImageWithCaching(for: favorite.avatarUrl)
        }
    }
}

// MARK: - Setup UI

extension FavoriteCell {
    func configure() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        
        accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            
            usernameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }
}
