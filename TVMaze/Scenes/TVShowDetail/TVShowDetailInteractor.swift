//
//  TVShowDetailInteractor.swift
//  TVMaze
//
//  Created by Râmede on 30/04/22.
//

import Foundation

protocol TVShowDetailInteractable: AnyObject {
    func bindTVShow(_ tvShow: TVShow)
}

final class TVShowDetailIntactor {
    
    // MARK: - Private Properties
    let presenter: TVShowDetailPresentable
    
    init(presenter: TVShowDetailPresentable) {
        self.presenter = presenter
    }
}

// MARK: - Internal Implementation
extension TVShowDetailIntactor: TVShowDetailInteractable {

    func bindTVShow(_ tvShow: TVShow) {
        presenter.presentTVShowDetail(tvShow)
    }
    
}
