//
//  EpisodeFactory.swift
//  TVMaze
//
//  Created by Râmede on 30/04/22.
//

import Foundation
import UIKit

struct EpisodeFactory {
    static func make(episode: Episode) -> EpisodeViewController {
        let presenter = EpisodePresenter()
        let service = TVShowsService(networkingDispatcher: NetworkingDispatcher())
        let interactor = EpisodeInteractor(
            presenter: presenter,
            service: service
        )
        let viewController = EpisodeViewController(episode: episode, interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
