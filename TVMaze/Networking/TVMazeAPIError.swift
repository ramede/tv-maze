//
//  TVMazeAPIError.swift
//  TVMaze
//
//  Created by Râmede on 27/04/22.
//

import Foundation

enum TVMazeAPIError: Error {
    case networking(code: Int, message: String)
    case fetch
    case parser
    case generic(message: String)
}
