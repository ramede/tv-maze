//
//  ViewController.swift
//  TVMaze
//
//  Created by Râmede on 27/04/22.
//

import UIKit

struct TvShow: Decodable {
    let name: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let api = "https://api.tvmaze.com/shows"
        let url = URL(string: api)
                
        NetworkingDispatcher().execute(sessionURL: url!) { (result: Result<[TvShow], Error>) in
            switch result {
            case .success(let response):
                print("😻😻😻 \(response)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
