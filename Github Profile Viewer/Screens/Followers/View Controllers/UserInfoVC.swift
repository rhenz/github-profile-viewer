//
//  UserInfoVC.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/3/22.
//

import UIKit

class UserInfoVC: UIViewController {
    
    // MARK: - Properties
    
    var username: String
    
    let headerView = UIView()
    
    // MARK: - Init
    required init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("selected username: \(username)")
        configureMainView()
        configureNavigationBar()
        getUserInfo()
        layoutUI()
    }
}

// MARK: - Setup UI

extension UserInfoVC {
    private func configureMainView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

// MARK: - Network Request

extension UserInfoVC {
    private func getUserInfo() {
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            self?.dismissLoadingView()
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GPVUserInfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentGPVAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}


// MARK: - Actions

extension UserInfoVC {
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}