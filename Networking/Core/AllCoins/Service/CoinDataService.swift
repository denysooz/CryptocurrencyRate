//
//  CoinDataService.swift
//  Networking
//
//  Created by Denis Dareuskiy on 28.07.24.
//

import Foundation

class CoinDataService {
    
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=40&page=1&sparkline=false&price_change_percentage=24h&locale=en"
    
    private let detailsUrlString = "https://api.coingecko.com/api/v3/coins/bitcoin?localization=false"
    
    func fetchCoins() async throws -> [Coin] {
        guard let url = URL(string: urlString) else { return [] }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CoinAPIError.requestFailed(description: "Request failed")
        }
            
        guard httpResponse.statusCode == 200 else {
            throw CoinAPIError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: data )
            return coins
        } catch let error {
            print("DEBUG: Error \(error.localizedDescription)")
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        guard let url = URL(string: detailsUrlString) else { return nil }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CoinAPIError.requestFailed(description: "Request failed")
        }
            
        guard httpResponse.statusCode == 200 else {
            throw CoinAPIError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        do {
            let details = try JSONDecoder().decode(CoinDetails.self, from: data )
            return details
        } catch let error {
            print("DEBUG: Error \(error.localizedDescription)")
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }
}

// MARK: - Completion Handlers

extension CoinDataService {
    func fetchCoins(completion: @escaping(Result<[Coin], CoinAPIError>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknownError(error: error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Request failed")))
                return
            }
                
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.invalidStatusCode(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data )
                completion(.success(coins))
            } catch {
                print("DEBUG: Failed to decode with error \(error)")
                completion(.failure(.jsonParsingFailure))
            }
        }.resume()
    }
    
    func fetchPrice(coin: String, completion: @escaping(Double) -> Void) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DEBUG: Failed with error \(error.localizedDescription)")
//                self.errorMessage = error.localizedDescription
                return
            }
                
            guard let data = data else { return }
            guard let jsonObjest = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let value = jsonObjest[coin] as? [String: Double] else { return }
            guard let price = value["usd"] else { return }
            
//            self.coin = coin.capitalized
//            self.price = "$\(price)"
                
            completion(price)
        }.resume()
    }

}
