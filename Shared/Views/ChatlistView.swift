//
//  ChatlistView.swift
//  sense-ios
//
//  Created by Michal Šimík on 03.03.2022.
//

import SwiftUI

struct ChatlistView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        if let splTokens = viewModel.splTokens {
            List {
                ForEach(splTokens, id: \.self) {
                    Text("\($0.tokenAddress)")
                }
            }
        } else {
            Text("loading").onAppear {
                Task {
                    await viewModel.getCoinList()
                }
            }
        }
    }
}
