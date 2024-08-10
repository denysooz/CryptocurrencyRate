//
//  MockCoinService.swift
//  Networking
//
//  Created by Denis Dareuskiy on 4.08.24.
//

import Foundation

class MockCoinService: CoinSeviceProtocol {
    func fetchCoins() async throws -> [Coin] {
        let bitcoin = Coin(id: "bitcoin", symbol: "btc", name: "Bitcoi", currentPrice: 59556, marketCapRank: 1, image: "")
        return [bitcoin]
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        let description = Description(text: "Bababa")
        let bitcoinDetails = CoinDetails(id: "bitcoin", symbol: "btc", name: "Bitcoin", description: description)
        return bitcoinDetails
    }
}
