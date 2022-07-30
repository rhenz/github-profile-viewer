//
//  PersistenceService.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/27/22.
//

import Foundation

enum RetrieveFavoritesResult {
    case success([User])
    case failure(GPVError)
}

protocol FavoriteUsersPersistenceService {
    var favoriteUsers: [User] { get }
    
    func save() throws
    func add(favorite: User)
    func remove(favorite: User)
    func retrieveFavorites(completion: @escaping (RetrieveFavoritesResult) -> Void)
    
}
