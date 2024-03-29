//
//  FavoritesListVC.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/14/22.
//

import UIKit

class FavoritesListVC: UITableViewController {
    
    // MARK: - Properties
    
    let favoritesStore: FavoritesStore
    let persistenceService: FavoriteUsersPersistenceService
    
    // MARK: - Init
    
    init(favoritesStore: FavoritesStore, persistenceService: FavoriteUsersPersistenceService) {
        self.favoritesStore = favoritesStore
        self.persistenceService = persistenceService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
}

// MARK: - Helper Methods

extension FavoritesListVC {
    func getFavorites() {
        persistenceService.retrieveFavorites { [weak self] result in
            switch result {
            case .success(let users):
                self?.favoritesStore.updateFavorites(users)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                self?.presentGPVAlertOnMainThread(title: "Retrieve Favorites Error", message: error.localizedDescription, buttonTitle: "Ok")
            }
        }
    }
}


// MARK: - Setup UI

extension FavoritesListVC {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        tableView.estimatedRowHeight = 80
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.cellId)
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Table View Datasource

extension FavoritesListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesStore.favorites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.cellId, for: indexPath) as? FavoriteCell else {
            fatalError("Failed to dequeue Favorite Cell")
        }
        
        // Configure cell
        cell.set(favorite: favoritesStore.favorites[indexPath.row])
        return cell
    }
}

// MARK: - Table View Delegate

extension FavoritesListVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let username = favoritesStore.favorites[indexPath.row].login
        let vc = FollowersListVC(username: username,
                                 favoritesStore: favoritesStore,
                                 persistenceService: persistenceService)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let user = favoritesStore.favorites[indexPath.row]
            favoritesStore.delete(user)
            
            // Save to persistence
            do {
                try persistenceService.save(favoritesStore.favorites)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                favoritesStore.insertUser(user, at: indexPath.row) // return user item back when this failed
                presentGPVAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "Ok")
            }
        }
    }
}
