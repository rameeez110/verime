//
//  SceneDelegate.swift
//  veriMe
//
//  Created by Rameez Hasan on 28/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        if let windowScence = scene as? UIWindowScene {
            
            self.window = UIWindow(windowScene: windowScence)
            
            if self.shouldAutoLogin() {
                self.initializeTabBar()
            } else {
                self.showWelcomeVC()
            }
            self.window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension SceneDelegate {
    func shouldAutoLogin() -> Bool{
        return false
    }
    
    func showWelcomeVC() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Register", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeVC")
            let navVC = UINavigationController(rootViewController: vc)
            navVC.navigationBar.isHidden = true
            self.window?.rootViewController = navVC
        }
    }
    
    func initializeTabBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
        let navVC = UINavigationController(rootViewController:tabBarController)
        navVC.view.frame = UIScreen.main.bounds
        navVC.navigationBar.isHidden = false
        self.window?.rootViewController = tabBarController
    }
}

