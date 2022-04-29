//
//  TVShowsService.swift
//  TVMaze
//
//  Created by Râmede on 28/04/22.
//

import Foundation

protocol TVShowsServiceProtocol {
    func fetchTVShows(completion: @escaping (Result<[TVShow], TVMazeAPIError>) -> Void)
}

final class TVShowsService {
    private let networkingDispatcher: NetworkingDispatcherType
    
    init(networkingDispatcher: NetworkingDispatcherType) {
        self.networkingDispatcher = networkingDispatcher
    }
}

// MARK: - Internal Implematations
extension TVShowsService: TVShowsServiceProtocol {
    
    func fetchTVShows(completion: @escaping (Result<[TVShow], TVMazeAPIError>) -> Void) {
        
        let endpoint = TVMazeAPIEndpoint.getShows.baseUrl + TVMazeAPIEndpoint.getShows.path
        guard let url = URL(string: endpoint) else { return }
        
        DispatchQueue.global().async {
            self.networkingDispatcher.execute(sessionURL: url) { (result: Result<[TVShow], TVMazeAPIError>) in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(TVMazeAPIError.generic(message: error.localizedDescription)))
                }
            }
        }
        
    }
    
}

