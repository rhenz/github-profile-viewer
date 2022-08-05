//
//  Device.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 8/5/22.
//

import UIKit

enum Device: String {
    case iPodTouch7thGen = "iPod touch (7th generation)"
    case other
}

extension UIDevice {
    static var modelName: Device {
        if self.current.name == Device.iPodTouch7thGen.rawValue {
            return .iPodTouch7thGen
        } else {
            return .other
        }
    }
}
