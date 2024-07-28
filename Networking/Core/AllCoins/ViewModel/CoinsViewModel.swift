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
    
    init() {
        fetchPrice(coin: "litecoin")
    }
    
    func fetchPrice(coin: String) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        print("Fetcing price...")
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            print("Did receive data \(data)")
            
            guard let jsonObjest = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            
            guard let value = jsonObjest[coin] as? [String: Any] else { return }
            guard let price = value["usd"] else { return }
            
            DispatchQueue.main.async {
                self.coin = coin.capitalized
                self.price = "$\(price)"
            }
        }.resume()
        
        print("Did reach end of function")
    }
}
