//
//  TVShowsTableViewController.swift
//  TVMaze
//
//  Created by Râmede on 27/04/22.
//

import UIKit

class TVShowsTableViewController: UITableViewController {
    
    // MARK: - Private Properties
    private var searchController = UISearchController(searchResultsController: nil)
    private let activityIndicator = UIActivityIndicatorView()
    private var tvShows: [String] = ["Girls", "Breaking Bad", "Better Call Saul", "The Rookie", "Ozark", "S.W.A.T", "New Amsterdam", "Hudson", "One Star Reviews", "The Beat", "Goodwood Members Meeting Highlights", "Muspilli", "The World of Lee Evans", "Broken Bread", "Teorias da Conspiração"]
    
    init() {
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
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
        searchController.searchResultsUpdater = self
        
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    
    }
    
}

extension TVShowsTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        if searchText.count == 0 {
            tableView.reloadData()
            return
        }
        tableView.reloadData()
    }
    
}

// MARK: - TableView Delegate
extension TVShowsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tvShows.count == 0 {
            return 1
        }
        return tvShows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as? TVShowTableViewCell else { return UITableViewCell() }

        cell.name = tvShows[indexPath.row]

        return cell
    }
    
}
