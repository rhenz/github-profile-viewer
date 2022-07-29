//
//  FavoritesListVC.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/14/22.
//

import UIKit

class FavoritesListVC: UIViewController {
    
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
        view.backgroundColor = .systemBackground
    }
}
