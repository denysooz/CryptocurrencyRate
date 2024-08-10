//
//  CoinDetailsView.swift
//  Networking
//
//  Created by Denis Dareuskiy on 2.08.24.
//

import SwiftUI

struct CoinDetailsView: View {
    let coin: Coin
    @ObservedObject var viewModel: CoinDetailsViewModel
    
    init(coin: Coin, service: CoinSeviceProtocol) {
        self.coin = coin
        self.viewModel = CoinDetailsViewModel(coinId: coin.id, service: service)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let details = viewModel.coinDetails {
                HStack {
                    VStack {
                        Text(details.name)
                            .fontWeight(.semibold)
                            .font(.subheadline)
                        
                        Text(details.symbol.uppercased())
                            .font(.footnote)
                        
                    }
                    
                    Spacer()
                    
                    CoinImageView(url: coin.image)
                        .frame(width: 64, height: 64)
                }
                
                Text(details.description.text)
                    .font(.footnote)
                    .padding(.vertical)
                
            }
        }
        .task {
            await viewModel.fetchCoinDetails()
        }
//        .onAppear {
//            self.task = Task { await viewModel.fetchCoinDetails() }
//        }
//        .onDisappear() {
//            task?.cancel()
//        }
        .padding()
    }
}

//#Preview {
//    CoinDetailsView()
//}
