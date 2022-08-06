//
//  FollowersListVC.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/15/22.
//

import UIKit

class FollowersListVC: UIViewController {
    
    // MARK: -
    
    enum Section {
        case main
    }
    
    // MARK: - Properties
    
    var username: String
    private var followers: [Follower] = [] {
        didSet {
            if followers.count < followersPerPage { self.hasMoreFollowers = false }
            self.updateData(for: self.followers)
        }
    }
    
    private var filteredFollowers: [Follower] = []
    
    private var currentPage = 1
    private var hasMoreFollowers = true
    private let followersPerPage = 100
    private var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    let favoritesStore: FavoritesStore
    let persistenceService: FavoriteUsersPersistenceService
    
    // MARK: - Init
    
    init(username: String, favoritesStore: FavoritesStore, persistenceService: FavoriteUsersPersistenceService) {
        self.username = username
        self.favoritesStore = favoritesStore
        self.persistenceService = persistenceService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Should not initialize FollowersListVC using init(coder:)")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSearchController()
        configureCollectionView()
        configureViewController()
        getFollowers(username: username, page: currentPage)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - Helper Methods

extension FollowersListVC {
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as? FollowerCell else {
                fatalError("Failed to dequeue reusable cell of FollowerCell")
            }
            
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(for followers: [Follower]) {
        DispatchQueue.global(qos: .userInteractive).async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
            snapshot.appendSections([.main])
            snapshot.appendItems(followers)
            
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func resetFollowerListVCState() {
        currentPage = 1
        isSearching = false
        followers.removeAll()
        filteredFollowers.removeAll()
        updateData(for: followers)
    }
}

// MARK: - Setup UI

extension FollowersListVC {
    private func configureNavigationBar() {
        navigationItem.title = username
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addToFavoritesButtonTapped(_:)))
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnLayout(in: view))
        
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
        
        // Set delegate
        collectionView.delegate = self
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
    }
    
    func showEmptyFollowersView() {
        DispatchQueue.main.async {
            let message = "This user doesn't have any followers. Go follow them! 😃"
            let emptyStateView = GPVEmptyStateView(message: message)
            emptyStateView.frame = self.view.bounds
            self.view.addSubview(emptyStateView)
        }
    }
}

// MARK: - Actions

extension FollowersListVC {
    
    @objc func addToFavoritesButtonTapped(_ sender: UIBarButtonItem) {
        
        // Check if user favorited already.
        if favoritesStore.favorites.contains(where: {$0.login.lowercased() == self.username.lowercased() }) {
            presentGPVAlertOnMainThread(title: "Notice", message: "You favorited this user already.", buttonTitle: "Ok")
            return
        }
        
        // Save to Favorites
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            self?.dismissLoadingView()
            guard let self = self else { return }
            switch result {
            case .success(let user):
                // Save to favorites
                self.favoritesStore.add(user)
                do {
                    try self.persistenceService.save(self.favoritesStore.favorites)
                } catch {
                    self.presentGPVAlertOnMainThread(title: "Saving Favorites Error", message: error.localizedDescription, buttonTitle: "Ok")
                }
            case .failure(let error):
                self.presentGPVAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "Ok")
            }
        }
    }
}

// MARK: - Network Request

extension FollowersListVC {
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            self?.dismissLoadingView()
            guard let self = self else { return }
            
            switch result {
            case .success(let followers):
                if followers.isEmpty {
                    self.showEmptyFollowersView()
                } else {
                    self.followers.append(contentsOf: followers)
                }
            case .failure(let error):
                self.presentGPVAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > (contentHeight - height) {
            guard hasMoreFollowers else { return }
            currentPage += 1
            getFollowers(username: username, page: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC(username: follower.login)
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

// MARK: - UISearchResultsUpdating

extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(for: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(for: followers)
    }
}

// MARK: - User Info VC Delegate

extension FollowersListVC: UserInfoVCDelegate {
    func userInfoVC(_ userInfoVC: UserInfoVC, didTapGetFollowersFor user: User) {
        
        // Update current username
        self.username = user.login
        
        // Update navigation bar title
        navigationItem.title = username
        
        // Reset VC State
        resetFollowerListVCState()
        
        // Get Followers
        getFollowers(username: self.username, page: currentPage)
    }
}
