//
//  PlistFavoriteUsersPersistenceManager.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/27/22.
//

import Foundation
import UIKit

class PlistFavoriteUsersPersistenceManager: FavoriteUsersPersistenceService {
    
    
    // MARK: - Properties
    
    private let favoritesFilePath: URL = {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return directory.appendingPathComponent("FavoriteUsers.plist")
    }()
    
    private(set) var favoriteUsers = [User]()
    
    // MARK: - Init
    
    init() {
        // Add observer when didEnterBackground
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(saveChanges),
                                       name: UIScene.didEnterBackgroundNotification,
                                       object: nil)
    }
    
    
    // MARK: - Methods
    
    func add(favorite: User)  {
        favoriteUsers.append(favorite)
    }
    
    func remove(favorite: User) {
        if let index = favoriteUsers.firstIndex(of: favorite) {
            favoriteUsers.remove(at: index)
        }
    }
    
    func retrieveFavorites(completion: @escaping (RetrieveFavoritesResult) -> Void) {
        guard let data = try? Data(contentsOf: favoritesFilePath) else {
            completion(.failure(.invalidData))
            return
        }
        
        do {
            let decoder = PropertyListDecoder()
            favoriteUsers = try decoder.decode([User].self, from: data)
            completion(.success(favoriteUsers))
        } catch {
            completion(.failure(.failedToRetrieveFavorites))
        }
    }
    
    func save() throws {
        do {
            let encoder = PropertyListEncoder()
            let encodedFavorites = try encoder.encode(favoriteUsers)
            try encodedFavorites.write(to: favoritesFilePath)
        } catch {
            throw GPVError.unableToFavorite
        }
    }
}

// MARK: - Actions

extension PlistFavoriteUsersPersistenceManager {
    @objc func saveChanges() {
        try? save()
    }
}
