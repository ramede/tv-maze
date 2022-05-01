//
//  TVShowDetailFactory.swift
//  TVMaze
//
//  Created by Râmede on 30/04/22.
//

import Foundation
import UIKit

struct TVShowDetailFactory {
    static func make(
        tvShow: TVShow,
        flowController: TVMazeFlowControllerType
    ) -> TVShowDetailViewController {
        let presenter = TVShowDetailPresenter()
        let service = TVShowDetailService(networkingDispatcher: NetworkingDispatcher())
        let interactor = TVShowDetailIntactor(
            presenter: presenter,
            service: service,
            flowController: flowController
        )
        let viewController = TVShowDetailViewController(tvShow: tvShow, interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
