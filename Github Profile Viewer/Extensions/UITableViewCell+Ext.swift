//
//  UITableViewCell+Ext.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/29/22.
//

import UIKit

extension UITableViewCell {
    static var cellId: String {
        String(describing: Self.self)
    }
}
