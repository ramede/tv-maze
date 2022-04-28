//
//  TVMazeFlowController.swift
//  TVMaze
//
//  Created by Râmede on 27/04/22.
//

import UIKit

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
        let viewController = TVShowsTableViewController()
        push(viewController: viewController)
    }
    
}
