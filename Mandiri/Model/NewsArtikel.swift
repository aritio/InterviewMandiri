//
//  NewsArtikel.swift
//  Mandiri
//
//

import Foundation

struct NewsArtikel: Codable {
    
    let author: String?
    let title: String?
    let description: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case url
    }
}
