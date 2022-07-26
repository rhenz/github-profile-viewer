//
//  UserInfoVC.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/3/22.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGithubProfile()
    func didTapGetFollowers()
}

class UserInfoVC: UIViewController {
    
    // MARK: - Properties
    
    var username: String
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GPVBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
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
        layoutUI()
        getUserInfo()
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
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemViews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
   
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
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
                    
                    let repoItemVC = GPVRepoItemVC(user: user)
                    repoItemVC.delegate = self
                    
                    let followersItemVC = GPVFollowersItemVC(user: user)
                    followersItemVC.delegate = self
                    
                    
                    self.add(childVC: repoItemVC, to: self.itemViewOne)
                    self.add(childVC: followersItemVC, to: self.itemViewTwo)
                    self.dateLabel.text = "Github since " + user.createdAt.convertToDisplayFormat
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


// MARK: -

extension UserInfoVC: GPVRepoItemVCDelegate, GPVFollowersItemVCDelegate {
    func didTapRepoButton(_ repoItemVC: GPVRepoItemVC) {
        print("Did Tap Repo Button")
    }
    
    func didTapFollowersButton(_ followersItemVC: GPVFollowersItemVC) {
        print("Did Tap Followers Button")
    }
}
