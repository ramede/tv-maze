//
//  NetworkingDispatcher.swift
//  TVMaze
//
//  Created by Râmede on 27/04/22.
//

import Foundation
import os

protocol NetworkingDispatcherType {
    func execute<T: Decodable>(sessionURL: URL, completion : @escaping (Result<[T], Error>) -> Void)
}

class NetworkingDispatcher: NetworkingDispatcherType {
    
    init() {
    }
    
    func execute<T: Decodable>(sessionURL: URL, completion : @escaping (Result<[T], Error>) -> Void) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: sessionURL) { (data, response, error) in
            
            // TODO: handle status code
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            
            if error == nil {
                if let safeData = data {
                    do {
                        let decodedData = try JSONDecoder().decode([T].self, from: safeData)
                        completion(.success(decodedData))
                    } catch {
                        os_log("Unable to decode data. Body: %{public}@", String(data: safeData, encoding: .utf8) ?? "")
                        completion(.failure(TVMazeError.parser))
                    }
                } else {
                    completion(.failure(TVMazeError.fetch))
                }
            } else {
                completion(.failure(TVMazeError.generic(
                                        message: "Error in URLSessionDataTask: \(String(describing: error))"
                        )
                    )
                )
            }
        }
        dataTask.resume()
    }
    
}
