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
    
    @Published var coinDetails: CoinDetails?
    
    
    init(coinId: String) {
        print("DEBUG: Init")
        self.coinId = coinId
        
        Task { await fetchCoinDetails() }
    }
    
    @MainActor
    func fetchCoinDetails() async {
        do {
            let details = try await serivce.fetchCoinDetails(id: coinId)
            print("DEBUG: Details \(details)")
            self.coinDetails = details
            
        } catch {
            print("DEBUG: Error \(error.localizedDescription)")
        }
    }
}
