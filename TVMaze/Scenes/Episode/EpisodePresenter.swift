//
//  EpisodePresenter.swift
//  TVMaze
//
//  Created by Râmede on 30/04/22.
//

import Foundation

protocol EpisodePresentable: AnyObject {
    var viewController: EpisodeDisplayable? { get set }
    func presentEpisode(_ episode: Episode)
    func presentLoading(_ isLoading: Bool)
    func presentDownloadImage(_ image: Data?)
}

final class EpisodePresenter {
    weak var viewController: EpisodeDisplayable?
}

// MARK: - Presentable Implemantations
extension EpisodePresenter: EpisodePresentable {

    func presentEpisode(_ episode: Episode) {
        viewController?.displayEpisode(episode)
    }

    func presentLoading(_ isLoading: Bool) {
        viewController?.displayLoading(isLoading)
    }
    
    func presentDownloadImage(_ image: Data?) {
        viewController?.displayDownloadedImage(image)
    }

}

