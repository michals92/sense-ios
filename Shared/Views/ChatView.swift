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
    @State var message: String = ""

    @State var tabBarController: UITabBarController?

    var body: some View {
        VStack {
            List {
                ForEach(homeData.messages) {
                    Text($0.message)
                }
            }
            HStack {
                TextField("Message", text: $message)
                Button {
                    homeData.sendMessage(message: message)
                } label: {
                    Text("send")
                }
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
