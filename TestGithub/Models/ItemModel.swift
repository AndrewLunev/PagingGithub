//
//  ItemModel.swift
//  TestGithub
//
//  Created by Andrey Lunev on 20/09/2018.
//  Copyright © 2018 Andrey Lunev. All rights reserved.
//

import Foundation

struct Item: Codable {
    
    var name: String
    var full_name: String
    var owner: Owner
    
}
