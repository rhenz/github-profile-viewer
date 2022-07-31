//
//  SceneDelegate.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/14/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Properties
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Setup Appearances
        configureAppearanceForiOS15()
        configureNavigationBar()
        
        // Initialize Window
        window = UIWindow(windowScene: windowScene)
        
        // Setup Root View Controller
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
    }
}

// MARK: - Helper Methods

private extension SceneDelegate {
    func createTabBar() -> UITabBarController {
        let tabBar = MainTabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        return tabBar
    }
    
    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }
    
    func configureAppearanceForiOS15() {
        // Setup UITabBar Appearance for iOS 15
        if #available(iOS 15, *) {
            // Setup Tab Bar Appearance like the default appearance in previous iOS Versions
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            
            // For navigation bar
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithDefaultBackground()
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
            UINavigationBar.appearance().compactAppearance = navBarAppearance
        }
    }
}
