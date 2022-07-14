//
//  GPVFollowersItemVC.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/14/22.
//

import Foundation

class GPVFollowersItemVC: GPVItemInfoVC {
    
    // MARK: - Properties
    private var user: User!
    
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
        configureUI()
    }
}

// MARK: - Setup UI

extension GPVFollowersItemVC {
    private func configureUI() {
        itemInfoViewOne.setContent(withCount: user.publicRepos, for: .followers)
        itemInfoViewTwo.setContent(withCount: user.publicGists, for: .following)
        actionButton.set(backgroundColor: .systemGreen, title: "Git Followers")
    }
}

