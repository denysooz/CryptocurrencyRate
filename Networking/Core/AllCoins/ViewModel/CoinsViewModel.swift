//
//  CoinsViewModel.swift
//  Networking
//
//  Created by Denis Dareuskiy on 27.07.24.
//

import Foundation

class CoinsViewModel: ObservableObject {
    
    @Published var coin = ""
    @Published var price = ""
    @Published var errorMessage: String?
    
    init() {
        fetchPrice(coin: "litecoin")
    }
    
    func fetchPrice(coin: String) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
            if let error = error {
                print("DEBUG: Failed with error \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                return
            }
                
            guard let httpResponse = response as? HTTPURLResponse else {
                self.errorMessage = "Bad HTTP response"
                return
            }
                
            guard httpResponse.statusCode == 200 else {
                self.errorMessage = "Failed to fetch with status code \(httpResponse.statusCode)"
                return
            }
                
            print("DEBUG: Responce code is \(httpResponse.statusCode)")
                
            guard let data = data else { return }
            guard let jsonObjest = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let value = jsonObjest[coin] as? [String: Any] else { return }
            guard let price = value["usd"] else { return }
            
            self.coin = coin.capitalized
            self.price = "$\(price)"
            }
        }.resume()
    }
}
