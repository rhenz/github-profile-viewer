//
//  User.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/18/22.
//

import Foundation

struct User: Codable, Equatable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let followers: Int
    let following: Int
    var createdAt: String
}

extension User: UserInfoPresentable { }
