//
//  GPVTextField.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/14/22.
//

import UIKit

class GPVTextField: UITextField {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("You should not initialize GPVTextField using init(coder:)")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: CGFloat.leastNonzeroMagnitude, height: 50)
    }
    
    // MARK: - Helper Methods
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        placeholder = "Enter a username"
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
    }
}
