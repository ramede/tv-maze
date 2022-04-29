//
//  TVShowsViewModel.swift
//  TVMaze
//
//  Created by Râmede on 28/04/22.
//

import Foundation

protocol TVShowsInteractoractable: AnyObject {
    func loadTVShows()
}

final class TVShowsInteractor {
    
    private let service: TVShowsServiceProtocol
    private let presenter: TVShowsPresentable
    
    init(
        service: TVShowsServiceProtocol,
        presenter: TVShowsPresentable
    ) {
        self.service = service
        self.presenter = presenter
    }
    
}

// MARK: - Internal Implementation
extension TVShowsInteractor {
    
    func loadTVShows() {
        presenter.presentLoading(true)
        service.fetchTVShows { [weak self] result in
            guard let self = self else { return }
            self.presenter.presentLoading(false)
            switch result {
            case .success(let tvShows):
                print("😻😻😻 \(tvShows)")
                self.presenter.presentTVShows(tvShows)
            case .failure(let error):
                print("👹👹👹 \(error)")
            }
        }
    }
    
}
