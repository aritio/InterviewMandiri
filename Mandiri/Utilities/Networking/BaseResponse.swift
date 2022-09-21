//
//  BaseResponse.swift
//  Mandiri
//
//  Created by Aritio modernland on 15/03/22.
//

import Foundation

struct BaseResponse: Codable {
    let status: Bool?
    let pesan: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case pesan
    }
}
