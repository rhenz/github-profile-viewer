//
//  GPVSecondaryTitleLabel.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/4/22.
//

import UIKit

class GPVSecondaryTitleLabel: UILabel {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("You should not init \(String(describing: Self.self)) using init(coder:)")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    // MARK: - Helper Methods
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        textColor = .secondaryLabel
        lineBreakMode = .byTruncatingTail
    }
}
