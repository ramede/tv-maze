//
//  TVShow.swift
//  TVMaze
//
//  Created by Râmede on 28/04/22.
//

import Foundation

struct Rating: Codable {
    let average: Double?
}

struct Schedule: Codable {
    let time: String?
    let days: [String]?
}

struct TVShow: Codable {
    let id: Int
    let name: String?
    let rating: Rating?
    let schedule: Schedule?
    let genres: [String]?
    let summary: String?
    let image: Image?
    var didFetchImage: Bool?
    var imageData: Data?
}
