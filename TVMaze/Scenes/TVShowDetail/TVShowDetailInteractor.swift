//
//  TVShowDetailInteractor.swift
//  TVMaze
//
//  Created by Râmede on 30/04/22.
//

import Foundation

protocol TVShowDetailInteractable: AnyObject {
    func goToEpisode(_ episode: Episode)
    func bindTVShow(_ tvShow: TVShow)
    func loadEpisodes(showId: Int)
}

final class TVShowDetailIntactor {
    
    // MARK: - Private Properties
    private let presenter: TVShowDetailPresentable
    private let service: TVShowDetailServiceProtocol
    private let flowController: TVMazeFlowControllerType
    
    init(
        presenter: TVShowDetailPresentable,
        service: TVShowDetailServiceProtocol,
        flowController: TVMazeFlowControllerType
    ) {
        self.presenter = presenter
        self.service = service
        self.flowController = flowController
    }
}

// MARK: - Internal Implementation
extension TVShowDetailIntactor: TVShowDetailInteractable {
    
    func goToEpisode(_ episode: Episode) {
        flowController.navigateToEpisode(episode)
    }

    func bindTVShow(_ tvShow: TVShow) {
        presenter.presentTVShowDetail(tvShow)
    }
    
    func loadEpisodes(showId: Int) {
        presenter.presentLoading(true)
        service.fetchEpisodes(id: showId) { [weak self] result in
            guard let self = self else { return }
            self.presenter.presentLoading(false)
            switch result {
            case .success(let episodes):
                self.presenter.presentEpisodes(episodes)
            case .failure(let error):
                print("👹👹👹 \(error)")
            }
        }

    }
    
}
