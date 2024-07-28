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
        fetchPrice()
    }
    
    func fetchPrice() {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=near&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        print("Fetcing price...")
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("Did receive data \(data)")
        }.resume()
        
        print("Did reach end of function")
    }
}
