//
//  TVShowsFactory.swift
//  TVMaze
//
//  Created by Râmede on 28/04/22.
//

import Foundation
import UIKit

struct TVShowsFactory {
    static func make(
        navigationController: UINavigationController
    ) -> TVShowsTableViewController {
        let presenter = TVShowsPresenter()
        let service = TVShowsService(networkingDispatcher: NetworkingDispatcher())
        let interactor = TVShowsInteractor(service: service, presenter: presenter)
        let viewController = TVShowsTableViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
