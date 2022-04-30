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
        let interactor = TVShowDetailIntactor(presenter: presenter)
        let viewController = TVShowDetailViewController(tvShow: tvShow, interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
