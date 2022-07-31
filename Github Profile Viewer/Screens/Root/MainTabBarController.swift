//
//  MainTabBarController.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/31/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private(set) var favoritesStore: FavoritesStore
    
    // MARK: - Init
    
    init() {
        favoritesStore = FavoritesStore()
        super.init(nibName: nil, bundle: nil)
        
        // Setup Tab Bar Controller
        
        let searchVC = SearchVC(favoritesStore: favoritesStore)
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let favoritesListVC = FavoritesListVC(favoritesStore: favoritesStore, persistenceService: PlistFavoriteUsersPersistenceManager())
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        
        let searchNavVC = UINavigationController(rootViewController: searchVC)
        let favoritesListNavVC = UINavigationController(rootViewController: favoritesListVC)
        viewControllers = [searchNavVC, favoritesListNavVC]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}