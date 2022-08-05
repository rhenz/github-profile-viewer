//
//  SearchVC.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/14/22.
//

import UIKit

class SearchVC: UIViewController, KeyboardDismissable {

    // MARK: - UI
    
    let logoImageView = UIImageView()
    let usernameTextField = GPVTextField()
    let callToActionButton = GPVButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    // MARK: - Properties
    
    private var isUsernameEntered: Bool { !(usernameTextField.text?.isEmpty ?? false) }
    let favoritesStore: FavoritesStore
    
    // MARK: - Init
    
    init(favoritesStore: FavoritesStore) {
        self.favoritesStore = favoritesStore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Helper Methods
    
    @objc private func pushToFollowersListVC() {
        guard let username = usernameTextField.text, isUsernameEntered else {
            print("Username is empty!")
            presentGPVAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😅", buttonTitle: "Ok")
            return
        }
        
        let followersListVC = FollowersListVC(username: username, favoritesStore: favoritesStore, persistenceService: PlistFavoriteUsersPersistenceManager())
        navigationController?.pushViewController(followersListVC, animated: true)
    }
}

// MARK: - UITextField Delegate

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToFollowersListVC()
        return true
    }
}

// MARK: - Setup UI

extension SearchVC {
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: Styles.Images.logo)
        logoImageView.contentMode = .scaleAspectFit
        
        let topAnchorConstant: CGFloat = UIDevice.modelName == .iPodTouch7thGen ? 10 : 80
        let widthHeightConstant: CGFloat = UIDevice.modelName == .iPodTouch7thGen ? 170 : 200
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topAnchorConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: widthHeightConstant),
            logoImageView.widthAnchor.constraint(equalToConstant: widthHeightConstant)
        ])
    }
    
    private func configureTextField() {
        view.addSubview(usernameTextField)
        
        usernameTextField.returnKeyType = .go
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    private func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        
        callToActionButton.addTarget(self, action: #selector(pushToFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
}
