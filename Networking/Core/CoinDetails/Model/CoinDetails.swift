//
//  CoinDetails.swift
//  Networking
//
//  Created by Denis Dareuskiy on 2.08.24.
//

import Foundation

struct CoinDetails: Decodable {
    let id: String
    let symbol: String
    let name: String
    let description: Description
}

struct Description: Decodable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "en"
    }
}
