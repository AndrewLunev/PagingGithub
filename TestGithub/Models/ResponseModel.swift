//
//  ResponseModel.swift
//  TestGithub
//
//  Created by Andrey Lunev on 19/09/2018.
//  Copyright © 2018 Andrey Lunev. All rights reserved.
//

import Foundation

struct ResponseModel: Codable {
    
    var total_count: Int
    var incomplete_results: Bool
    var items: [Item]
    
}
