//
//  KeychainWalletStorage.swift
//  sense-ios
//
//  Created by Michal Šimík on 02.03.2022.
//

import Foundation
import Solana
import KeychainSwift

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
