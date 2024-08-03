//
//  CoinDetailsViewModel.swift
//  Networking
//
//  Created by Denis Dareuskiy on 2.08.24.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    
    private let serivce = CoinDataService()
    private let coinId: String
    
    init(coinId: String) {
        self.coinId = coinId
        
        Task { await fetchCoinDetails() }
    }
    
    func fetchCoinDetails() async {
        do {
            print("DEBUG")
            let details = try await serivce.fetchCoinDetails(id: coinId)
            print("DEBUG: Details \(details)")
            
        } catch {
            print("DEBUG: Error \(error.localizedDescription)")
        }
    }
}
