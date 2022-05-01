//
//  EpisodeViewController.swift
//  TVMaze
//
//  Created by Râmede on 30/04/22.
//

import UIKit

protocol EpisodeDisplayable: AnyObject {
    func displayEpisode(_ episode: Episode)
    func displayLoading(_ isLoading: Bool)
    func displayDownloadedImage(_ imageData: Data?)
}

class EpisodeViewController: UIViewController {
    
    // MARK: - Private Properties
    private lazy var contentView = EpisodeView()
    
    private let episode: Episode
    private let interactor: EpisodeInteractable

    
    init(
        episode: Episode,
        interactor: EpisodeInteractor
    ) {
        self.episode = episode
        self.interactor = interactor
        super.init(nibName: nil, bundle: .main)
        contentView.delegate = self
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
        title = "Episode"
        interactor.bindEpisode(episode)
        if let image = episode.image?.medium {
            interactor.downloadImage(from: image)
        }
    }
    
}

// MARK: - Private Implementations
private extension EpisodeViewController {
    
}

// MARK: - EpisodeViewDelegate Implementation
extension EpisodeViewController: EpisodeViewDelegate {
    
    func didTapOnClose() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Displayable Iplamentation
extension EpisodeViewController: EpisodeDisplayable {
    
    func displayEpisode(_ episode: Episode) {
        contentView.bindEpisodeData(episode)
    }
    
    func displayLoading(_ isLoading: Bool) {
        contentView.isLoading = isLoading
    }

    func displayDownloadedImage(_ image: Data?) {
        contentView.bindImage(imageData: image)
    }

}
