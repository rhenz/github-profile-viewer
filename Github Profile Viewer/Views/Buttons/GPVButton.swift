//
//  GPVButton.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/14/22.
//

import UIKit

class GPVButton: UIButton {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("You should not initialize GPVButton using init(coder:)")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: CGFloat.leastNonzeroMagnitude, height: 50)
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        
        configure()
    }
    
    // MARK: - Helper Methods
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
}
