//
//  TVEpisode.swift
//  TVMaze
//
//  Created by Râmede on 30/04/22.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let summary: String
    let image: Image?
}
