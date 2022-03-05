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

    var body: some View {
            if let splTokens = viewModel.splTokens {
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
        }
    }
}
