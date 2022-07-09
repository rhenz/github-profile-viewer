//
//  FollowersLoader.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/9/22.
//

import Foundation

enum LoadFollowersResult {
    case success([Follower])
    case failure(Error)
}

protocol RemoteFollowersLoader {
    func load(completion: @escaping (LoadFollowersResult) -> Void)
}
