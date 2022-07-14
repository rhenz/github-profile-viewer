//
//  UserInfoPresentable.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/11/22.
//

import Foundation

protocol UserInfoPresentable {
    var publicRepos: Int { get }
    var publicGists: Int { get }
    var followers: Int { get }
    var following: Int { get }
}
