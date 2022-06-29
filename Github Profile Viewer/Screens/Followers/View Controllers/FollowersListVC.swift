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
            guard followers.isEmpty else { return }
            DispatchQueue.main.async { self.showEmptyStateView(with: "This user doesn't have any followers. Go follow them! 😃", in: self.view) }
        }
    }
    private var filteredFollowers: [Follower] = []
    
    private var currentPage = 1
    private var hasMoreFollowers = true
    private let followersPerPage = 100
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    // MARK: - Init
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
        self.title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("Should not initialize FollowersListVC using init(coder:)")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // MARK: - Helper Methods
    
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
}

// MARK: - Setup UI

extension FollowersListVC {
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
}

// MARK: - Endpoint Call Methods

extension FollowersListVC {
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            self?.dismissLoadingView()
            guard let self = self else { return }
            
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                self.updateData(for: self.followers)
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
}

// MARK: - UISearchResultsUpdating

extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(for: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(for: followers)
    }
}
