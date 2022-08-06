//
//  GPVRepoItemVC.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/14/22.
//

import UIKit

protocol GPVRepoItemVCDelegate: AnyObject {
    func gpvRepoItemVC(_ controller: GPVRepoItemVC, didTapRepoButtonFor user: User)
}


class GPVRepoItemVC: GPVItemInfoVC {
    
    // MARK: - Properties
    private var user: User!
    
    weak var delegate: GPVRepoItemVCDelegate?
    
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

// MARK: - Actions
extension GPVRepoItemVC {
    override func actionButtonTapped(_ sender: UIButton) {
        delegate?.gpvRepoItemVC(self, didTapRepoButtonFor: user)
    }
}

// MARK: - Setup UI

extension GPVRepoItemVC {
    private func configureUI() {
        itemInfoViewOne.setContent(withCount: user.publicRepos, for: .repos)
        itemInfoViewTwo.setContent(withCount: user.publicGists, for: .gists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
}

