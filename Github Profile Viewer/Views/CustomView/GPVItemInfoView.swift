//
//  GPVItemInfoView.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/8/22.
//

import UIKit

final class GPVItemInfoView: UIView {
    
    // MARK: - Properties
    
    let symbolImageView = UIImageView()
    let titleLabel = GPVTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GPVTitleLabel(textAlignment: .center, fontSize: 14)
    
    
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
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}

// MARK: - Public Methods

extension GPVItemInfoView {
    func setContent(withCount count: Int, for itemInfoType: ItemInfoType) {
        self.titleLabel.text = itemInfoType.title
        self.symbolImageView.image = itemInfoType.image
        self.countLabel.text = "\(count)"
    }
}

// MARK: - Types

extension GPVItemInfoView {
    enum ItemInfoType {
        case repos
        case gists
        case followers
        case following
        
        var image: UIImage? {
            switch self {
            case .repos:
                return UIImage(systemName: Styles.SFSymbols.repos)
            case .gists:
                return UIImage(systemName: Styles.SFSymbols.gists)
            case .followers:
                return UIImage(systemName: Styles.SFSymbols.followers)
            case .following:
                return UIImage(systemName: Styles.SFSymbols.following)
            }
        }
        
        var title: String {
            switch self {
            case .repos:
                return "Public Repos"
            case .gists:
                return "Public Gists"
            case .followers:
                return "Followers"
            case .following:
                return "Following"
            }
        }
    }
}
