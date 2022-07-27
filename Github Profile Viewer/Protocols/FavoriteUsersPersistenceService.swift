//
//  PersistenceService.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/27/22.
//

import Foundation

protocol FavoriteUsersPersistenceService {
    typealias RetrieveFavoritesResult = ((GPVError?) -> Void)
    
    var favoriteUsers: [User] { get }
    
    func save() throws
    func add(favorite: User)
    func remove(favorite: User)
    func retrieveFavorites(completion: RetrieveFavoritesResult?)
    
}
