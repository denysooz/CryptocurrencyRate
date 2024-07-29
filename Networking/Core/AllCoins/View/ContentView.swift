//
//  ContentView.swift
//  Networking
//
//  Created by Denis Dareuskiy on 27.07.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CoinsViewModel()
    var body: some View {
        VStack {
            if let errorMesage = viewModel.errorMessage {
                Text(errorMesage)
            } else {
                Text("\(viewModel.coin): \(viewModel.price)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
