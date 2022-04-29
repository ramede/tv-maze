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

struct TVShow: Codable {
    let id: Int
    let name: String
    let rating: Rating
}
