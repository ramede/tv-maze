//
//  TVShowsViewModel.swift
//  TVMaze
//
//  Created by Râmede on 28/04/22.
//

import Foundation

protocol TVShowsInteractoractable: AnyObject {
    func searchTVShows(query: String)
    func downloadImage(from url: String, with idx: IndexPath)
    func loadTVShows(to page: Int)
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
    
    func searchTVShows(query: String) {
        presenter.presentLoading(true)
        service.searchTVShows(query: query) { [weak self] result in
            guard let self = self else { return }
            self.presenter.presentLoading(false)
            switch result {
            case .success(let tvShowsSerach):
                let tvShows = tvShowsSerach.map { return $0.show }
                self.presenter.presentTVShows(tvShows)
            case .failure(let error):
                print("👹👹👹 \(error)")
            }
        }
    }
    
    func downloadImage(from url: String, with idx: IndexPath) {
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
    
    func loadTVShows(to page: Int) {
        presenter.presentLoading(true)
        service.fetchTVShows(to: page) { [weak self] result in
            guard let self = self else { return }
            self.presenter.presentLoading(false)
            switch result {
            case .success(let tvShows):
                self.presenter.presentTVShows(tvShows)
            case .failure(let error):
                print("👹👹👹 \(error)")
            }
        }
    }
        
}
