//
//  EpisodeInteractor.swift
//  TVMaze
//
//  Created by Râmede on 30/04/22.
//

import Foundation

protocol EpisodeInteractable: AnyObject {
    func bindEpisode(_ episode: Episode)
    func downloadImage(from url: String)
}

final class EpisodeInteractor {
    
    // MARK: - Private Properties
    private let presenter: EpisodePresentable
    private let service: TVShowsServiceProtocol
    
    init(
        presenter: EpisodePresentable,
        service: TVShowsServiceProtocol
    ) {
        self.presenter = presenter
        self.service = service
    }

}

// MARK: - Interactable Implementation
extension EpisodeInteractor: EpisodeInteractable {
    func bindEpisode(_ episode: Episode) {
        presenter.presentEpisode(episode)
    }
    
    func downloadImage(from url: String) {
        presenter.presentLoading(true)
        service.fetchImage(url: url) { (result: Result<Data?, Error>) in
            self.presenter.presentLoading(false)
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self.presenter.presentDownloadImage(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
