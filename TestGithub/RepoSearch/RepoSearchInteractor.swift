//
//  RepoSearchInteractor.swift
//  TestGithub
//
//  Created by Andrey Lunev on 20/09/2018.
//  Copyright © 2018 Andrey Lunev. All rights reserved.
//

import Foundation

protocol RepoSearchInteractorProtocolInput: class {
    func fetchAllReposFromDataManager(_ searchTag: String, page: Int)
}

protocol RepoSearchInteractorProtocolOutput: class {
    func providedPhotos(_ repos: [Item], totalPages: Int)
    func serviceError(_ error: Error)
}

class RepoSearchInteractor: RepoSearchInteractorProtocolInput {
    
    weak var repoSearchPresenter: RepoSearchInteractorProtocolOutput!
    var APIDataManager: RepoSearchDataManagerProtocol!
    
    func fetchAllReposFromDataManager(_ searchTag: String, page: Int) {
        APIDataManager.fetchReposForSearchText(searchText: searchTag, page: page, closure: { (error, totalPages, gitRepos) in
            if let repos = gitRepos {
                print(repos)
                self.repoSearchPresenter.providedPhotos(repos, totalPages: totalPages)
            } else if let error = error {
                self.repoSearchPresenter.serviceError(error)
            }
        })
    }
    
}
