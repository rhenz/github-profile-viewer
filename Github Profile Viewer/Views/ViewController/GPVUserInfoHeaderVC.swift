//
//  GPVUserInfoHeaderVC.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/4/22.
//

import UIKit

class GPVUserInfoHeaderVC: UIViewController {
    
    // MARK: - Properties
    
    var user: User
    
    // Header
    let avatarImageView = GPVAvatarImageView(frame: .zero)
    let usernameLabel = GPVTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GPVSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GPVSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GPVBodyLabel(textAlignment: .left)
    
    // MARK: - Init
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        setupViews()
    }
    
}

// MARK: - Setup UI

extension GPVUserInfoHeaderVC {
    func setupViews() {
        DispatchQueue.global().async { self.avatarImageView.setImageWithCaching(for: self.user.avatarUrl) }
        usernameLabel.text = user.login
        nameLabel.text = user.name
        locationLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "No bio available."
        locationImageView.image = UIImage(systemName: SFSymbols.location)
    }
    
    func addSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    func layoutUI() {
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.numberOfLines = 3
        bioLabel.lineBreakMode = .byTruncatingTail
        locationImageView.tintColor = .secondaryLabel
        
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
