//
//  CoinsViewModel.swift
//  Networking
//
//  Created by Denis Dareuskiy on 27.07.24.
//

import Foundation

class CoinsViewModel: ObservableObject {
    
    @Published var coins = [Coin]()
    @Published var errorMessage: String?
    
    private let service: CoinSeviceProtocol
    
    init(service: CoinSeviceProtocol) {
        self.service = service
    }
    
    @MainActor
    func fetchCoins () async {
        do {
            let coins = try await service.fetchCoins()
            self.coins.append(contentsOf: coins)
        } catch {
            guard let error = error as? CoinAPIError else { return }
                self.errorMessage = error.customDescription
            
        }
    }
    
//    func fetchCoinsWithCompletionHandler() {
//        service.fetchCoins { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let coins):
//                    self?.coins = coins
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
}
