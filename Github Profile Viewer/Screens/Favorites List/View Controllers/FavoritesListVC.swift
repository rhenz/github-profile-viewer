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
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.cellId, for: indexPath) as? FavoriteCell else {
            fatalError("Failed to dequeue Favorite Cell")
        }
        
        // Configure cell
        cell.set(favorite: Follower(login: "John Salvador", avatarUrl: "https://i.imgur.com/y8Bp4Uq.jpeg"))
        return cell
    }
}
