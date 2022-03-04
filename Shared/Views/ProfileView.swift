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
        NavigationView {
            VStack {
                Image("profile")
                    .resizable()
                    .frame(width: 140, height: 140, alignment: .center)

                if viewModel.account != nil {
                    List {
                        Section("Wallet") {
                            Text(viewModel.account?.publicKey.base58EncodedString ?? "")
                            Text(viewModel.balance ?? "")
                        }.listRowBackground(Spacer().background(Color(uiColor: UIColor(hex: "#EEEEEE") ?? .lightGray)))

                        Section("Settings") {
                            Button {
                                Task {
                                    await viewModel.requestAirdrop()
                                }
                            } label: {
                                Text("Airdrop 1 SOL")
                            }
                        }.listRowBackground(Spacer().background(Color(uiColor: UIColor(hex: "#EEEEEE") ?? .lightGray)))
                    }
                    .listStyle(.insetGrouped)
                    .introspectTableView { $0.backgroundColor = .white }

                    if let tokenValues = viewModel.tokenValues {
                        ForEach(tokenValues, id: \.self) { item in
                            // swiftlint:disable line_length
                            Text(item.account.data.parsed.info.tokenAmount.uiAmountString + " " + item.account.data.parsed.info.mint)
                        }
                    }
                } else {
                    Text("Add transition to import wallet")
                    Button {
                        viewModel.createAccount()
                    } label: {
                        Text("Create new account")
                    }
                }
            }
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
            .navigationBarHidden(false)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    viewModel.clear()
                } label: {
                    Text("Logout")
                }
            }
        }
    }
}
