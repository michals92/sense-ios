//
//  ContentView.swift
//  Shared
//
//  Created by Michal Šimík on 01.03.2022.
//

import SwiftUI
import Solana

struct ContentView: View {
    @StateObject var viewModel = MainViewModel()

    // let mnemonic = "tissue ghost fashion plastic become parrot permit icon convince thought place describe"

    var body: some View {
        VStack {
            if viewModel.account != nil {
                Button {
                    viewModel.getAccountInfo()
                } label: {
                    Text("get account info")
                }

                Button {
                    viewModel.clear()
                } label: {
                    Text("remove account")
                }

                Button {
                    viewModel.getBalance()
                } label: {
                    Text(" balance account")
                }
            } else {
                TextField("Enter account address", text: $viewModel.phrase)
                Button {
                    viewModel.saveAccount()
                } label: {
                    Text("connect")
                }
            }
        }.padding()
    }
}
