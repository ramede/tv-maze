//
//  TVShowsTableViewController.swift
//  TVMaze
//
//  Created by Râmede on 27/04/22.
//

import UIKit

protocol TVShowsDisplayable: AnyObject {
    func displayLoading(_ isLoading: Bool)
    func displayTVShows(_ tvShows: [TVShow])
    func displayDownloadedImage(_ image: Data?, on idx: IndexPath)
}

class TVShowsTableViewController: UITableViewController {
        
    // MARK: - Private Properties
    private let interactor: TVShowsInteractoractable
    private var searchController = UISearchController(searchResultsController: nil)
    private let activityIndicator = UIActivityIndicatorView()
    private var tvShows: [TVShow] = []
    private var page: Int = 0
    
    init(interactor: TVShowsInteractoractable) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor.loadTVShows(to: page)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY >= (scrollView.contentSize.height - scrollView.bounds.height) - 20 {
            page += 1
            interactor.loadTVShows(to: page)
        }
    }

}

// MARK: - Private Implementation
private extension TVShowsTableViewController {
    
    private func setup() {
        setupNavigationBar()
        setupSerachController()
        setupActivityIndicator()
        setupTableView()
        setupConstraints()
    }
    
    private func setupSerachController() {
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.automaticallyShowsScopeBar = false
        
        searchController.searchBar.backgroundColor = .systemGray6
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = .systemGray6
    }
    
    private func setupActivityIndicator() {
        activityIndicator.color = .systemBlue
    }
            
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.setStatusBar(backgroundColor: .systemGray6)
        navigationItem.title = "TVMaze | Shows"
    }
            
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        tableView.backgroundColor = .systemGray6
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UIScreen.main.bounds.height * 65 / 100
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.register(TVShowTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundView = activityIndicator
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchController.searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchController.searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

private extension TVShowsTableViewController {
    
    @objc private func refresh() {
    
    }
    
}

// MARK: - SearchBar Delegate
extension TVShowsTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchController.searchBar.text ?? ""
        tvShows = []
        interactor.searchTVShows(query: searchText)
        searchController.isActive = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    
    }
    
}

// MARK: - TableView Delegate
extension TVShowsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as? TVShowTableViewCell else { return UITableViewCell() }

        cell.imageData = tvShows[indexPath.row].imageData
        cell.name = tvShows[indexPath.row].name ?? ""
        cell.rating = "⭐ \(String(tvShows[indexPath.row].rating?.average ?? 0))"
        
        if let imageUrl = tvShows[indexPath.row].image?.medium {
            if tvShows[indexPath.row].didFetchImage == nil ||
               tvShows[indexPath.row].didFetchImage == false {
                interactor.downloadImage(from: imageUrl, with: indexPath)
            }
        }
        
        return cell
    }
    
}

// MARK: - Displaybles Implementation
extension TVShowsTableViewController: TVShowsDisplayable {
    
    func displayLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }

    func displayTVShows(_ tvShows: [TVShow]) {
        DispatchQueue.main.async {
            self.tvShows.append(contentsOf: tvShows)
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func displayDownloadedImage(_ image: Data?, on idx: IndexPath) {
        if idx.row >= tvShows.startIndex && idx.row < tvShows.endIndex {
            tvShows[idx.row].imageData = image
            tvShows[idx.row].didFetchImage = true
            DispatchQueue.main.async() {
                UIView.performWithoutAnimation {
                    self.tableView.reloadRows(at: [idx], with: .none)
                }
            }
        }
    }

}
