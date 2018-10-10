//
//  RepoSearchPresenter.swift
//  TestGithub
//
//  Created by Andrey Lunev on 20/09/2018.
//  Copyright © 2018 Andrey Lunev. All rights reserved.
//

import Foundation

protocol RepoSearchPresenterProtocolInput: RepoSearchViewControllerProtocolOutput, RepoSearchInteractorProtocolOutput {
    
}

class RepoSearchPresenter: RepoSearchPresenterProtocolInput {
    
    weak var view: RepoSearchViewControllerProtocolInput!
    var repoSearchInteractorInput: RepoSearchInteractorProtocolInput!
    
    func fetchPhotos(_ searchTag: String, page: Int) {
        repoSearchInteractorInput.fetchAllReposFromDataManager(searchTag, page: page)
    }
    
    func providedPhotos(_ repos: [Item], totalPages: Int) {
        self.view.displayFetchedRepos(repos, totalPages: totalPages)
    }

    func serviceError(_ error: Error) {
        self.view.displayErrorView("Some Error")
    }
}
