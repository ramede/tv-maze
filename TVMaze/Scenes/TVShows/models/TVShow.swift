//
//  TVShow.swift
//  TVMaze
//
//  Created by Râmede on 28/04/22.
//

import Foundation

struct Image: Codable {
    let medium: String?
}

struct Rating: Codable {
    let average: Double?
}

struct TVShow: Codable {
    let id: Int
    let name: String
    let rating: Rating
    let image: Image
    var didFetchImage: Bool?
    var imageData: Data?
}
