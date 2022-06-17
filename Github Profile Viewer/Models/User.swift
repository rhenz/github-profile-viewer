//
//  User.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/18/22.
//

import Foundation

struct User: Decodable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var followers: Int
    var following: Int
    
    #warning("Can make this Data type and change dateDecodingStrategy")
    var createdAt: String
}
