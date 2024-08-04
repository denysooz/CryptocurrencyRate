//
//  CoinDetailsViewModel.swift
//  Networking
//
//  Created by Denis Dareuskiy on 2.08.24.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    
    private let serivce: CoinDataService
    private let coinId: String
    
    @Published var coinDetails: CoinDetails?
    
    init(coinId: String, service: CoinDataService) {
        self.serivce = service
        self.coinId = coinId
    }
    
    @MainActor
    func fetchCoinDetails() async {
        do {
            self.coinDetails  = try await serivce.fetchCoinDetails(id: coinId)
        } catch {
            print("DEBUG: Error \(error.localizedDescription)")
        }
    }
}
