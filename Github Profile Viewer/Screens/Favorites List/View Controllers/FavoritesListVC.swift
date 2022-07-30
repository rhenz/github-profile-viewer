//
//  FavoritesListVC.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/14/22.
//

import UIKit

class FavoritesListVC: UITableViewController {
    
    // MARK: - Properties
    
    var persistenceService: FavoriteUsersPersistenceService
    
    private var favorites = [User]()
    
    // MARK: - Init
    
    init(persistenceService: FavoriteUsersPersistenceService) {
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
                self?.favorites = users
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
        return favorites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.cellId, for: indexPath) as? FavoriteCell else {
            fatalError("Failed to dequeue Favorite Cell")
        }
        
        // Configure cell
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
}

// MARK: - Table View Delegate

extension FavoritesListVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
