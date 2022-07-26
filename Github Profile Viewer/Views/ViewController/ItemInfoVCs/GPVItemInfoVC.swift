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
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureStackView()
        configureButton()
        layoutUI()
    }    
}

// MARK: - Setup UI

extension GPVItemInfoVC {
    private func configureButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
    }
    
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

// MARK: - Actions

extension GPVItemInfoVC {
    @objc func actionButtonTapped(_ sender: UIButton) { }
}
