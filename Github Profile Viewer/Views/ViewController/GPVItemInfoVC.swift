//
//  GPVItemInfoVC.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/11/22.
//

import UIKit

class GPVItemInfoVC: UIViewController {

    // MARK: - Properties
    
    let stackView = UIStackView()
    let itemInfoViewOne = GPVItemInfoView()
    let itemInfoViewTwo = GPVItemInfoView()
    let actionButton = GPVButton()
    
    // MARK: - Init
    init(for user: UserInfoPresentable, itemInfoViewTypeOne: GPVItemInfoView.ItemInfoType, itemInfoViewTypeTwo: GPVItemInfoView.ItemInfoType) {
        super.init(nibName: nil, bundle: nil)
        
        itemInfoViewOne.setContent(withCount: displayCount(for: itemInfoViewTypeOne, user: user), for: itemInfoViewTypeOne)
        itemInfoViewTwo.setContent(withCount: displayCount(for: itemInfoViewTypeTwo, user: user), for: itemInfoViewTypeTwo)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureStackView()
        layoutUI()
    }
    
    private func displayCount(for itemInfoViewType: GPVItemInfoView.ItemInfoType, user: UserInfoPresentable) -> Int {
        switch itemInfoViewType {
        case .repos:
            return user.publicRepos
        case .gists:
            return user.publicGists
        case .followers:
            return user.followers
        case .following:
            return user.following
        }
    }
    
}

// MARK: - Setup UI

extension GPVItemInfoVC {
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
