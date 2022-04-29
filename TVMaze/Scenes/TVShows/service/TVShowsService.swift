//
//  TVShowsService.swift
//  TVMaze
//
//  Created by Râmede on 28/04/22.
//

import Foundation

protocol TVShowsServiceProtocol {
    func searchTVShows(query: String, completion: @escaping (Result<[TVShowSearch], Error>) -> Void)
    func fetchTVShows(to page: Int, completion: @escaping (Result<[TVShow], TVMazeAPIError>) -> Void)
    func fetchImage(url: String, completion: @escaping (Result<Data?, Error>) -> Void)
}

final class TVShowsService {
    private let networkingDispatcher: NetworkingDispatcherType
    
    init(networkingDispatcher: NetworkingDispatcherType) {
        self.networkingDispatcher = networkingDispatcher
    }
}

// MARK: - Internal Implematations
extension TVShowsService: TVShowsServiceProtocol {
    
    func searchTVShows(query: String, completion: @escaping (Result<[TVShowSearch], Error>) -> Void) {
        let endpoint = TVMazeAPIEndpoint.searchShows(params: ["q": query])
        var components = URLComponents(string: endpoint.baseUrl + endpoint.path)
        components?.queryItems = endpoint.queryParameters
        
        guard let url = components?.url else { return }
                
        DispatchQueue.global().async {
            self.networkingDispatcher.execute(sessionURL: url) { (result: Result<[TVShowSearch], TVMazeAPIError>) in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(TVMazeAPIError.generic(message: error.localizedDescription)))
                }
            }
        }
    }
    
    func fetchTVShows(to page: Int, completion: @escaping (Result<[TVShow], TVMazeAPIError>) -> Void) {
        let endpoint = TVMazeAPIEndpoint.getShows(params: ["page": String(page)])
        var components = URLComponents(string: endpoint.baseUrl + endpoint.path)
        components?.queryItems = endpoint.queryParameters
        
        guard let url = components?.url else { return }
                
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
    
    func fetchImage(url: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        DispatchQueue.global().async {
            self.networkingDispatcher.downloadImage(from: url) { (result: Result<Data?, Error>) in
                switch result {
                case .success(let data):
                    guard let data = data else { return }
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(TVMazeAPIError.generic(message: error.localizedDescription)))
                }
            }
        }
    }
    
}

