//
//  SearchVC.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/14/22.
//

import UIKit

class SearchVC: UIViewController {

    // MARK: - UI
    
    let logoImageView = UIImageView()
    let usernameTextField = GPVTextField()
    let callToActionButton = GPVButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}
