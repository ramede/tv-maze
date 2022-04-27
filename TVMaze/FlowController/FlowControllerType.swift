//
//  FlowControllerType.swift
//  TVMaze
//
//  Created by Râmede on 27/04/22.
//

import UIKit

protocol FlowControllerType: AnyObject {
    var navigationController: UINavigationController { get }
    var currentViewController: UIViewController? { get set }
    func start()
}

extension FlowControllerType {
    
    func push(viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
        currentViewController = viewController
    }

    func present(viewController: UIViewController, animated: Bool = true) {
        navigationController.topViewController?.present(viewController, animated: true, completion: nil)
    }

    func popToPreviousViewController() {
        navigationController.popViewController(animated: true)
        currentViewController = navigationController.viewControllers.last
    }
    
}
