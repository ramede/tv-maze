//
//  TVMazeFlowController.swift
//  TVMaze
//
//  Created by Râmede on 27/04/22.
//

import UIKit

protocol TVMazeFlowControllerType: AnyObject {
    func navigateToTVShowDetail()
}

public class TVMazeFlowController: FlowControllerType {
    
    var navigationController: UINavigationController
    var currentViewController: UIViewController?

    init(navigationController: UINavigationController) {

        self.navigationController = navigationController
    }
    
    deinit {
        currentViewController = nil
    }
    
    func start() {
        let viewController = TVShowsFactory.make(navigationController: navigationController)
        push(viewController: viewController)
    }
    
}


// MARK: - TVMazeFlowControllerType Implementation
extension TVMazeFlowController: TVMazeFlowControllerType {
    
    func navigateToTVShowDetail() {
        let viewController = TVShowDetailViewController()
        push(viewController: viewController)
    }
    
}
