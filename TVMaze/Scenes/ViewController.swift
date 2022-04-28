//
//  ViewController.swift
//  TVMaze
//
//  Created by Râmede on 27/04/22.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Private Properties
    private var searchController = UISearchController(searchResultsController: nil)
    private let activityIndicator = UIActivityIndicatorView()
    private var tvShows: [String] = ["Foo1", "Foo2", "Foo3", "Foo4", "Foo5", "Foo6", "Foo7", "Foo8", "Foo9", "Foo10", "Foo11", "Foo12", "Foo13", "Foo14", "Foo15"]
    
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
private extension ViewController {
    
    func setup() {
        setupNavigationBar()
        setupSerachController()
        setupActivityIndicator()
        setupTableView()
        setupConstraints()
    }
    
    func setupSerachController() {
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
    
    func setupActivityIndicator() {
        activityIndicator.color = .systemBlue
    }
            
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.setStatusBar(backgroundColor: .systemGray6)
        navigationItem.title = "TVMaze | Shows"
    }
            
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        tableView.backgroundColor = .systemGray5
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UIScreen.main.bounds.height * 65 / 100
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundView = activityIndicator
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchController.searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchController.searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

private extension ViewController {
    @objc private func refresh() {
    }
}

// MARK: - SearchBar Delegate
extension ViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    
}

extension ViewController: UISearchResultsUpdating {

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
extension ViewController {
    
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
        ) as? TableViewCell else { return UITableViewCell() }

        cell.text = tvShows[indexPath.row]

        return cell
    }
    
}
