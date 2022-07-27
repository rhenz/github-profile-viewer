//
//  PersistenceService.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/27/22.
//

import Foundation

protocol FavoriteUsersPersistenceService {
    typealias RetrieveFavoritesResult = ((GPVError?) -> Void)
    
    var favoriteUsers: [User] { get set }
    
    func retrieveFavorites(completion: RetrieveFavoritesResult?)
    func save() throws
}
