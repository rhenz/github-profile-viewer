//
//  GPVAvatarImageView.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/21/22.
//

import UIKit

class GPVAvatarImageView: UIImageView {
    
    // MARK: -
    
    private let cache = NetworkManager.shared.cache
    let placeholderImage = UIImage(named: Styles.Images.avatarPlaceholder)!

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Methods
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
    }
    
}
