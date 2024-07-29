//
//  Coin.swift
//  Networking
//
//  Created by Denis Dareuskiy on 28.07.24.
//

import Foundation

struct Coin: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
//    let currentPrice: Double
//    let marketCapRank: Int
}
