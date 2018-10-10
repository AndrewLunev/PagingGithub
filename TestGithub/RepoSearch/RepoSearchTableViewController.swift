//
//  RepoSearchTableViewController.swift
//  TestGithub
//
//  Created by Andrey Lunev on 19/09/2018.
//  Copyright © 2018 Andrey Lunev. All rights reserved.
//

import UIKit

protocol RepoSearchViewControllerProtocolOutput: class {
    func fetchPhotos(_ searchTag: String, page: Int)
}

protocol RepoSearchViewControllerProtocolInput: class {
    func displayFetchedRepos(_ repos: [Item]?, totalPages: Int)
    func displayErrorView(_ errorMessage: String)
}

class RepoSearchTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    // MARK: - Properties
    
    var repoSearchPresenter: RepoSearchViewControllerProtocolOutput!
    var repos: [Item] = []
    var currentPage = 1
    var totalPages = 1
    
    let threshold: CGFloat = 100.0
    var isLoadingMore = false

    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        RepoSearchAssembly.sharedInstance.configure(self)
    }
    
    
    
    // MARK: - Private
    
    func resetSearch() {
        
        self.title = searchBar.text
        currentPage = 1
        repos = []
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        if searchBar.text != nil && searchBar.text != "" {
            
            repoSearchPresenter.fetchPhotos(searchBar.text!, page: currentPage)
        }
    }
}



// MARK: - RepoSearchViewControllerProtocolInput

extension RepoSearchTableViewController: RepoSearchViewControllerProtocolInput {
    
    func displayFetchedRepos(_ repos: [Item]?, totalPages: Int) {
        
        self.repos.append(contentsOf: repos!)
        self.totalPages = totalPages
        self.isLoadingMore = false
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayErrorView(_ errorMessage: String) {
        
        let refreshAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
}



// MARK: - UIScrollViewDelegate

extension RepoSearchTableViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if !isLoadingMore && (maximumOffset - contentOffset <= threshold)
            && searchBar.text != nil && searchBar.text != "" {
            
            self.isLoadingMore = true
            repoSearchPresenter.fetchPhotos(searchBar.text!, page: currentPage)
        }
    }
}



// MARK: - UISearchBarDelegate

extension RepoSearchTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        resetSearch()
    }
}



// MARK: - UITableViewDataSource

extension RepoSearchTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoSearchCell", for: indexPath)
        
        cell.textLabel?.text = repos[indexPath.row].name
        cell.detailTextLabel?.text = repos[indexPath.row].full_name
        
        return cell
    }
}



// MARK: - UITableViewDelegate

extension RepoSearchTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
