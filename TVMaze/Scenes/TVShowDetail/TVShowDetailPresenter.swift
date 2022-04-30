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
}

final class TVShowDetailPresenter {
    weak var viewController: TVShowDetailDisplayable?
}

// MARK: - Presentable Implemantations
extension TVShowDetailPresenter: TVShowDetailPresentable {

    func presentTVShowDetail(_ tvShow: TVShow) {
        viewController?.displayTVShowDetail(tvShow)
    }

}
