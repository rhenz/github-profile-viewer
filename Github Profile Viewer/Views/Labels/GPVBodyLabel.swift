//
//  GFBodyLabel.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/16/22.
//

import UIKit

class GPVBodyLabel: UILabel {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You should not init \(String(describing: Self.self)) using init(coder:)")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        
        self.textAlignment = textAlignment
        
        configure()
    }
    
    
    // MARK: - Helper Methods
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.preferredFont(forTextStyle: .body)
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
    }

}
