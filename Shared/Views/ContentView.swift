//
//  ContentView.swift
//  Shared
//
//  Created by Michal Šimík on 01.03.2022.
//

import SwiftUI
import Solana

struct ContentView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        TabView {
            ChatlistView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "message")
                    Text("Chatrooms")
                }
            ProfileView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
