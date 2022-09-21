//
//  NewsCategories.swift
//
//

import Foundation

struct NewsCategories: Codable {
    
    let id: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

