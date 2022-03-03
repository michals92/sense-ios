//
//  Model.swift
//  sense-ios
//
//  Created by Michal Šimík on 02.03.2022.
//

import Foundation

// MARK: - Welcome
struct TokenAccountResult: Codable {
    let jsonrpc: String
    let result: Result2
    let id: Int
}

// MARK: - Result
struct Result2: Codable {
    let context: Context
    let value: [Value]
}

// MARK: - Context
struct Context: Codable {
    let slot: Int
}

// MARK: - Value
struct Value: Codable, Hashable {
    let account: Account2
    let pubkey: String
}

// MARK: - Account
struct Account2: Codable, Hashable {
    let data: DataClass
    let executable: Bool
    let lamports: Int
    let owner: String
    let rentEpoch: Int
}

// MARK: - DataClass
struct DataClass: Codable, Hashable {
    let parsed: Parsed
    let program: String
    let space: Int
}

// MARK: - Parsed
struct Parsed: Codable, Hashable {
    let info: Info
    let type: String
}

// MARK: - Info
struct Info: Codable, Hashable {
    let isNative: Bool
    let mint, owner, state: String
    let tokenAmount: TokenAmount
}

// MARK: - TokenAmount
struct TokenAmount: Codable, Hashable {
    let amount: String
    let decimals, uiAmount: Int
    let uiAmountString: String
}
