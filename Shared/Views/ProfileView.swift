//
//  ProfileView.swift
//  sense-ios
//
//  Created by Michal Šimík on 03.03.2022.
//

import SwiftUI
import Solana

struct ProfileView: View {
    @ObservedObject var viewModel: MainViewModel

    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

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
                    Text("logout")
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
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .top
        )
        .onAppear {
            viewModel.getBalance()
        }
        .onReceive(timer) { _ in
            viewModel.getBalance()
        }
    }
}
