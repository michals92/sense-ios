//
//  ChatlistView.swift
//  sense-ios
//
//  Created by Michal Šimík on 03.03.2022.
//

import SwiftUI

struct ChatlistView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var selectionValue: String? {
        didSet {
            selection = true
        }
    }
    @State private var selection: Bool = false

    var body: some View {
        NavigationView {
            NavigationLink(destination: ChatView(viewModel: viewModel), isActive: $selection) {
                if let splTokens = viewModel.splTokens {
                    List(splTokens, id: \.self, selection: $selectionValue) {
                        Text("\($0.tokenAddress)")
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
}
