//
//  TVShowDetailInteractor.swift
//  TVMaze
//
//  Created by Râmede on 30/04/22.
//

import Foundation

protocol TVShowDetailInteractable: AnyObject {
    func bindTVShow(_ tvShow: TVShow)
    func loadEpisodes(showId: Int)
}

final class TVShowDetailIntactor {
    
    // MARK: - Private Properties
    private let presenter: TVShowDetailPresentable
    private let service: TVShowDetailServiceProtocol
    
    init(
        presenter: TVShowDetailPresentable,
        service: TVShowDetailServiceProtocol
    ) {
        self.presenter = presenter
        self.service = service
    }
}

// MARK: - Internal Implementation
extension TVShowDetailIntactor: TVShowDetailInteractable {

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
