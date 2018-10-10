//
//  RepoSearchAssembly.swift
//  TestGithub
//
//  Created by Andrey Lunev on 20/09/2018.
//  Copyright © 2018 Andrey Lunev. All rights reserved.
//

import Foundation

class RepoSearchAssembly {
    
    static let sharedInstance = RepoSearchAssembly()
    
    func configure(_ viewController: RepoSearchTableViewController) {
        
        let APIDataManager = GithubDataManager()
        let interactor = RepoSearchInteractor()
        let presenter = RepoSearchPresenter()
        
        viewController.repoSearchPresenter = presenter
        presenter.view = viewController
        presenter.repoSearchInteractorInput = interactor
        interactor.repoSearchPresenter = presenter
        interactor.APIDataManager = APIDataManager
    }
    
}
