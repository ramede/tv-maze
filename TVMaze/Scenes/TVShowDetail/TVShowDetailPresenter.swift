//
//  TVShowDetailPresenter.swift
//  TVMaze
//
//  Created by Râmede on 30/04/22.
//

import Foundation

protocol TVShowDetailPresentable: AnyObject {
    var viewController: TVShowDetailDisplayable? { get set }
    func presentTVShowDetail(_ tvShow: TVShow)
    func presentLoading(_ isLoading: Bool)
    func presentEpisodes(_ episodes: [Episode])
}

final class TVShowDetailPresenter {
    weak var viewController: TVShowDetailDisplayable?
}

// MARK: - Presentable Implemantations
extension TVShowDetailPresenter: TVShowDetailPresentable {

    func presentTVShowDetail(_ tvShow: TVShow) {
        viewController?.displayTVShowDetail(tvShow)
    }

    func presentLoading(_ isLoading: Bool) {
        viewController?.displayLoading(isLoading)
    }
    
    func presentEpisodes(_ episodes: [Episode]) {
        viewController?.displayEpisodes(episodes)
    }

}
