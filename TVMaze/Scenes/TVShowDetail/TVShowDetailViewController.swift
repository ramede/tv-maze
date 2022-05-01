//
//  TVShowDetailViewController.swift
//  TVMaze
//
//  Created by Râmede on 29/04/22.
//

import UIKit

protocol TVShowDetailDisplayable: AnyObject {
    func displayEpisodes(_ episodes: [Episode])
    func displayTVShowDetail(_ tvShow: TVShow)
    func displayLoading(_ isLoading: Bool)
}

class TVShowDetailViewController: UIViewController {
    
    
    // MARK: - Private Properties
    private lazy var contentView = TVShowDetailView()
    private let tvShow: TVShow
    private let interactor: TVShowDetailInteractable

    
    init(
        tvShow: TVShow,
        interactor: TVShowDetailInteractable
    ) {
        self.tvShow = tvShow
        self.interactor = interactor
        super.init(nibName: nil, bundle: .main)
        self.contentView.delegate = self
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
        interactor.bindTVShow(tvShow)
        interactor.loadEpisodes(showId: tvShow.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

// MARK: - Private Implementations
private extension TVShowDetailViewController {
    
}


// MARK: - Displayble Implementations
extension TVShowDetailViewController: TVShowDetailDisplayable {
    
    func displayEpisodes(_ episodes: [Episode]) {
        contentView.bindEpisodes(episodes)
    }
    
    func displayTVShowDetail(_ tvShow: TVShow) {
        contentView.bindTVShowData(tvShow)
    }
    
    func displayLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.contentView.isLoading = isLoading
        }

    }
    
}

// MARK: - TVShowDetailViewDelegate Implementation
extension TVShowDetailViewController: TVShowDetailViewDelegate {
    
    func didTapOnEpisode(_ episode: Episode) {
        interactor.goToEpisode(episode)
    }
    
}
