//
//  KeyboardDismissable.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/15/22.
//

import UIKit

protocol KeyboardDismissable where Self: UIViewController {
    func createDismissKeyboardTapGesture()
}

extension KeyboardDismissable {
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}
