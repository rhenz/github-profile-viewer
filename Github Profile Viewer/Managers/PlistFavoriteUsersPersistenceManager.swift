//
//  PlistFavoriteUsersPersistenceManager.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/27/22.
//

import UIKit

class PlistFavoriteUsersPersistenceManager: FavoriteUsersPersistenceService {
    
    
    // MARK: - Properties
    
    private let favoritesFilePath: URL = {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return directory.appendingPathComponent("FavoriteUsers.plist")
    }()
    
    // MARK: - Init
    
    // MARK: - Methods
    
    func save(_ favorites: [User]) throws {
        do {
            let encoder = PropertyListEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            try encodedFavorites.write(to: favoritesFilePath)
        } catch {
            throw PersistenceServiceError.unableToSave
        }
    }
    
    func retrieveFavorites(completion: @escaping (RetrieveFavoritesResult) -> Void) {
        guard let data = try? Data(contentsOf: favoritesFilePath) else {
            completion(.success([]))
            return
        }

        do {
            let decoder = PropertyListDecoder()
            let favoriteUsers = try decoder.decode([User].self, from: data)
            completion(.success(favoriteUsers))
        } catch {
            completion(.failure(.unableToRetrieveFavorites))
        }
    }
}
