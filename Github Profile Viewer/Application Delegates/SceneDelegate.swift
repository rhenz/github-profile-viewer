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
}
