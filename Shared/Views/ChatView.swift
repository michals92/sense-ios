//
//  ChatView.swift
//  sense-ios
//
//  Created by Michal Šimík on 05.03.2022.
//

import SwiftUI

struct ChatView: View {
    @StateObject var homeData = HomeModel()
    @ObservedObject var viewModel: MainViewModel

    @State var tabBarController: UITabBarController?

    var body: some View {
        VStack {
            List {
                ForEach(homeData.messages) {
                    ChatRow(message: $0, user: viewModel.account?.publicKey.base58EncodedString ?? "")
                }
            }
            HStack {
                TextField("Message", text: $homeData.message)
                Button {
                    homeData.sendMessage()
                } label: {
                    Text("SEND")
                        .font(.caption2)
                }
                .background(Color.blue)
            }
            .padding()
        }.onAppear {
            homeData.onAppear()
        }

        .navigationTitle("Chat with Sarka")
        .navigationBarTitleDisplayMode(.inline)
        .introspectTabBarController { tabBarController in
            tabBarController.tabBar.isHidden = true
            self.tabBarController = tabBarController
        }
        .onDisappear {
            tabBarController?.tabBar.isHidden = false
        }
    }
}
