//
//  GithubDataManager.swift
//  TestGithub
//
//  Created by Andrey Lunev on 19/09/2018.
//  Copyright © 2018 Andrey Lunev. All rights reserved.
//

import Foundation
import Alamofire

protocol RepoSearchDataManagerProtocol: class {
    func fetchReposForSearchText(searchText: String, page: Int, closure: @escaping (Error?, Int, [Item]?) -> Void) -> Void
}

class GithubDataManager: RepoSearchDataManagerProtocol {
    
    struct GithubAPI {
        
        static let tagsSearchFormat = "https://api.github.com/search/repositories?q=%@&sort=stars&order=desc&page=%i"
    }
    
    func fetchReposForSearchText(searchText: String, page: Int, closure: @escaping (Error?, Int, [Item]?) -> Void) -> Void {
        
        let format = GithubAPI.tagsSearchFormat
        let arguments: [CVarArg] = [searchText, page]
        
        let reposURL = String(format: format, arguments: arguments)
        
        Alamofire.request(reposURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseString {
            response in switch response.result {
            case .success:
                
                let decodeData: ResponseModel = try! JSONDecoder().decode(ResponseModel.self, from: response.data!)
                
                var totalPages: Int
                
                if decodeData.total_count % 30 > 0 {
                    totalPages = decodeData.total_count / 30 + 1
                } else {
                    totalPages = decodeData.total_count / 30
                }
                
                closure(nil, totalPages, decodeData.items)
                
            case .failure(_):
                
                print(response.error!)
                closure(response.error, 0, nil)
            }
        }
    
    }
    
}
