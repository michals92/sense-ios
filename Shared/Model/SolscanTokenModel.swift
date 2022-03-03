//
//  SolscanTokenModel.swift
//  sense-ios
//
//  Created by Michal Šimík on 03.03.2022.
//

import Foundation

struct SolscanTokenResponse: Codable {
    let succcess: Bool
    let data: [SPLToken]
}

// MARK: - Datum
struct SPLToken: Codable, Hashable {
    let tokenAddress: String
    let tokenAmount: SPLTokenAmount
    let tokenAccount, tokenName, tokenIcon: String
    let rentEpoch, lamports: Int
}

// MARK: - TokenAmount
struct SPLTokenAmount: Codable, Hashable {
    let amount: String
    let decimals, uiAmount: Int
    let uiAmountString: String
}
