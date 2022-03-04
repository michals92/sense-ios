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
        NavigationView {
            if let splTokens = viewModel.splTokens {
                List {
                    ForEach(splTokens, id: \.self) {
                        Text("\($0.tokenAddress)")
                    }
                }
                .navigationTitle("Chatrooms")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("Loading").onAppear {
                    Task {
                        await viewModel.getCoinList()
                    }
                }
            }
        }
    }
}
