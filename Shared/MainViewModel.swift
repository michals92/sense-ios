//
//  MainViewModel.swift
//  sense-ios
//
//  Created by Michal Šimík on 01.03.2022.
//

import Foundation
import SwiftUI
import Solana
import KeychainSwift

final class MainViewModel: ObservableObject {

    let network = NetworkingRouter(endpoint: .devnetSolana)
    let accountStorage = KeychainAccountStorageModule()
    let solana: Solana

    @Published var account: Account?
    @Published var phrase = ""
    private var seedPhrase = ConcreteSeedPhrase()

    init() {
        self.solana = Solana(router: network, accountStorage: accountStorage)
        switch accountStorage.account {
        case .success(let account):
            self.account = account
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func getAccountInfo() {
        guard let account = account else {
            return
        }
// Hi4zJd7Vzxg8aYDyiPt31Jn4yyFszgxpw2f8RX7BdgjK
        solana.api.getAccountInfo(account: account.publicKey.base58EncodedString, decodedTo: AccountInfo.self) { result in
            print(result)
            switch result {
            case.success(let accountInfo):
                print(accountInfo)
            case .failure(let error):
                print(error)
            }
        }
    }

    func saveAccount() {
        let phrase = phrase.components(separatedBy: " ")
        let account = Account(phrase: phrase, network: .devnet)

        if let account = account {
            switch accountStorage.save(account) {
            case .failure(let error):
                print(error.localizedDescription)
            case .success:
                self.account = account
                print("success!")
            }
        }
    }

    func clear() {
        if case .success = accountStorage.clear() {
            self.account = nil
        }
    }

    func getBalance() {
        guard let account = account else {
            return
        }
        
        solana.api.getBalance(account: account.publicKey.base58EncodedString){ result in
            print(result)

            switch result {
            case .success(let amount):
                print(amount)
            case .failure(let error):
                print(error)
            }
         }
    }

    func requestAirdrop() {
        guard let account = account else {
            return
        }

        solana.api.requestAirdrop(account: account.publicKey.base58EncodedString, lamports: 10) { result in
            switch result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }

    func createAccount() {
        let phrase = getSeedPhrase()
        print(phrase)
        guard let account = Account(phrase: phrase, network: .devnet) else {
            print("failed to create account!")
            return
        }

        switch accountStorage.save(account) {
        case .success:
            print("success")
            self.account = account
        case .failure(let error):
            print(error)
        }
    }

    private func getSeedPhrase() -> SeedPhraseCollection {
        seedPhrase.getSeedPhrase()
    }
}
