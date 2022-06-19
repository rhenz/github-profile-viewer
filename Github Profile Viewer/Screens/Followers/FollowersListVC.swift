//
//  FollowersListVC.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/15/22.
//

import UIKit

class FollowersListVC: UIViewController {
    
    // MARK: - Properties
    
    var username: String
    
    // MARK: - Init
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
        self.title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("Should not initialize FollowersListVC using init(coder:)")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        NetworkManager.shared.getFollowers(for: username,
                                           page: 1) { followers, error in
            
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error!, buttonTitle: "Ok")
                return
            }

            print("Followers.count = \(followers.count)")
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Helper Methods
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
