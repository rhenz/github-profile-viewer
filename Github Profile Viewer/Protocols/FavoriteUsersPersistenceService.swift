//
//  PersistenceService.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/27/22.
//

import Foundation

enum RetrieveFavoritesResult {
    case success([User])
    case failure(PersistenceServiceError)
}

enum PersistenceServiceError: Error {
    case unableToSave
    case unableToRetrieveFavorites
}

protocol FavoriteUsersPersistenceService {
    func save(_ favorites: [User]) throws
    func retrieveFavorites(completion: @escaping (RetrieveFavoritesResult) -> Void)
}
