//
//  TVShowDetailViewController.swift
//  TVMaze
//
//  Created by Râmede on 29/04/22.
//

import UIKit

class TVShowDetailViewController: UIViewController {
    private lazy var contentView = TVShowDetailView()
    
    init() {
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "TV Show"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

// MARK: - Private Implementations
private extension TVShowDetailViewController {
    
}
