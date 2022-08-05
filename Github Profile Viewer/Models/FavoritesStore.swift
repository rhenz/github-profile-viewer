//
//  FavoritesStore.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/31/22.
//

import UIKit

class FavoritesStore {
    
    // MARK: - Properties
    
    private(set) var favorites = [User]()
    
    // MARK: - Helper Methods
    
    func add(_ user: User) {
        favorites.append(user)
    }
    
    func insertUser(_ user: User, at index: Int) {
        favorites.insert(user, at: index)
    }
    
    func delete(_ user: User) {
        if let index = favorites.firstIndex(of: user) {
            favorites.remove(at: index)
        }
    }
    
    func updateFavorites(_ users: [User]) {
        self.favorites = users
    }
}
