//
//  ContentView.swift
//  Shared
//
//  Created by Michal Šimík on 01.03.2022.
//

import SwiftUI
import Solana

struct ContentView: View {
    @ObservedObject var viewModel: MainViewModel

    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    // let mnemonic = "tissue ghost fashion plastic become parrot permit icon convince thought place describe"

    var body: some View {
        VStack {
            if viewModel.account != nil {
                Text(viewModel.account?.publicKey.base58EncodedString ?? "")
                Text(viewModel.balance ?? "")

                if let tokenValues = viewModel.tokenValues {
                    ForEach(tokenValues, id: \.self) { item in
                        // swiftlint:disable line_length
                        Text(item.account.data.parsed.info.tokenAmount.uiAmountString + " " + item.account.data.parsed.info.mint)
                    }
                }

                Button {
                    viewModel.clear()
                } label: {
                    Text("remove account")
                }

                Button {
                    viewModel.getBalance()
                } label: {
                    Text("update balance info")
                }

                Button {
                    Task {
                        await viewModel.requestAirdrop()
                    }
                } label: {
                    Text("airdrop 1 SOL")
                }
            } else {
                Text("add transition to import wallet")
                Button {
                    viewModel.createAccount()
                } label: {
                    Text("create new account")
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.getBalance()
            Task {
                await viewModel.getBallanceForMyCoin()
            }
        }
        .onReceive(timer) { _ in
            viewModel.getBalance()
        }
    }
}
