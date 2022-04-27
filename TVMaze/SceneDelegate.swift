//
//  SceneDelegate.swift
//  TVMaze
//
//  Created by Râmede on 27/04/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let navController = UINavigationController()
        let flowController = TVMazeFlowController(navigationController: navController)
        flowController.start()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        self.window = window
    }
    
}

