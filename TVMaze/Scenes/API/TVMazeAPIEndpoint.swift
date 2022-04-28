//
//  TVMazeAPIEndpoint.swift
//  TVMaze
//
//  Created by Râmede on 28/04/22.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryParameters: [URLQueryItem]? { get }
}

enum TVMazeAPIEndpoint: Endpoint {
    case getShows

    var baseUrl: String {
        get {
            return "https://api.tvmaze.com"
        }
    }
    
    var path: String {
        get {
            switch self {
            case .getShows:
                return "/shows"
            }
        }
    }
    
    var httpMethod: HTTPMethod {
        get {
            switch self {
            case .getShows:
                return .get
            }
        }
    }
    
    var queryParameters: [URLQueryItem]? {
        get {
            return nil
        }
    }
    
}
