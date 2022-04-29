//
//  TVShowsPresenter.swift
//  TVMaze
//
//  Created by Râmede on 28/04/22.
//

import Foundation

protocol TVShowsPresentable: AnyObject {
    var viewController: TVShowsDisplayable? { get set }
    func presentTVShows(_ tvShows: [TVShow])
    func presentLoading(_ isLoading: Bool)
}

final class TVShowsPresenter {
    weak var viewController: TVShowsDisplayable?
}

// MARK: - Presentable Implemantations
extension TVShowsPresenter: TVShowsPresentable {

    func presentTVShows(_ tvShows: [TVShow]) {
        viewController?.displayTVShows(tvShows)
    }
    
    func presentLoading(_ isLoading: Bool) {
        viewController?.displayLoading(isLoading)
    }

}
