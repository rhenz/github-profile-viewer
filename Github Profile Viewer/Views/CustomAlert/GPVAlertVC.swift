//
//  GPVAlertVC.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/16/22.
//

import UIKit

class GPVAlertVC: UIViewController {
    
    // MARK: -
    
    let containerView = UIView()
    let titleLabel = GPVTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GPVBodyLabel(textAlignment: .center)
    let actionButton = GPVButton(backgroundColor: .systemPink, title: "Ok")
    
    // MARK: -
    
    var alertTitle: String
    var message: String
    var buttonTitle: String
    
    let padding: CGFloat = 20
    
    // MARK: - Init
    
    init(title: String, message: String, buttonTitle: String) {
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You should not init \(String(describing: Self.self)) using init(coder:)")
    }

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Helper Methods
    
    private func setupViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
}

// MARK: - Selector Methods

extension GPVAlertVC {
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}


// MARK: - Setup UI
extension GPVAlertVC {
    func configureContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        
        titleLabel.text = alertTitle
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureActionButton() {
        containerView.addSubview(actionButton)
        
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        
        messageLabel.text = message
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
}
