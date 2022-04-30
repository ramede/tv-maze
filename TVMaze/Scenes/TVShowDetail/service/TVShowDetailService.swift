//
//  TVShowDetailService.swift
//  TVMaze
//
//  Created by Râmede on 30/04/22.
//

import Foundation

protocol TVShowDetailServiceProtocol {
    func fetchEpisodes(id: Int, completion: @escaping (Result<[Episode], TVMazeAPIError>) -> Void)
}

final class TVShowDetailService {
    private let networkingDispatcher: NetworkingDispatcherType
    
    init(networkingDispatcher: NetworkingDispatcherType) {
        self.networkingDispatcher = networkingDispatcher
    }
}

// MARK: - Internal Implematations
extension TVShowDetailService: TVShowDetailServiceProtocol {
    
    func fetchEpisodes(id: Int, completion: @escaping (Result<[Episode], TVMazeAPIError>) -> Void) {

        let endpoint = TVMazeAPIEndpoint.getEpisodes(id: id)
        var components = URLComponents(string: endpoint.baseUrl + endpoint.path)
        components?.queryItems = endpoint.queryParameters
        
        guard let url = components?.url else { return }

        DispatchQueue.global().async {
            self.networkingDispatcher.execute(sessionURL: url) { (result: Result<[Episode], TVMazeAPIError>) in
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

