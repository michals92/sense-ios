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

    let network = NetworkingRouter(endpoint: .mainnetBetaSolana)
    let accountStorage = KeychainAccountStorageModule()
    let solana: Solana

    @Published var account: Account?
    @Published var phrase = ""

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

        solana.api.getAccountInfo(account: account.publicKey.base58EncodedString, decodedTo: AccountInfo.self) { result in
            print(result)
        }
    }

    func saveAccount() {
        let phrase = phrase.components(separatedBy: " ")
        let account = Account(phrase: phrase, network: .mainnetBeta)

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
}

enum SolanaAccountStorageError: Error {
    case unauthorized
}

struct KeychainAccountStorageModule: SolanaAccountStorage {
    private let tokenKey = "Summer"
    private let keychain = KeychainSwift()

    func save(_ account: Account) -> Result<Void, Error> {
        do {
            let data = try JSONEncoder().encode(account)
            keychain.set(data, forKey: tokenKey)
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    var account: Result<Account, Error> {
        // Read from the keychain
        guard let data = keychain.getData(tokenKey) else { return .failure(SolanaAccountStorageError.unauthorized)  }
        if let account = try? JSONDecoder().decode(Account.self, from: data) {
            return .success(account)
        }
        return .failure(SolanaAccountStorageError.unauthorized)
    }

    func clear() -> Result<Void, Error> {
        keychain.clear()
        return .success(())
    }
}
