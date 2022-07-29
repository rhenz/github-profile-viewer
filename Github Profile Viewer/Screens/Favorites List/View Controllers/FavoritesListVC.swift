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
    }
}


// MARK: - Setup UI

extension FavoritesListVC {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
}

// MARK: - Table View Datasource

extension FavoritesListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
