//
//  TVShowsViewModel.swift
//  TVMaze
//
//  Created by Râmede on 28/04/22.
//

import Foundation

protocol TVShowsInteractoractable: AnyObject {
    func downloadImage(from url: String, with idx: Int)
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
extension TVShowsInteractor: TVShowsInteractoractable {
    func downloadImage(from url: String, with idx: Int) {
        service.fetchImage(url: url) { (result: Result<Data?, Error>) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self.presenter.presentDownloadImage(data, on: idx)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
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
