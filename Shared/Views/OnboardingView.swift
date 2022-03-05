//
//  OnboardingView.swift
//  sense-ios
//
//  Created by Michal Šimík on 03.03.2022.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: MainViewModel
    @State var showImportWallet = false

    var body: some View {
        NavigationView {
            VStack {
                Text("A new way to ").font(.system(size: 25)) +
                Text("connect people ").font(.system(size: 25, weight: .bold)) +
                Text("with the ").font(.system(size: 25)) +
                Text("same interest").font(.system(size: 25, weight: .bold))
                Spacer()
                Image("web")
                Spacer()
                Text("connect • chat • share • meet • enjoy")
                    .font(.system(size: 13, weight: .semibold))
                    .padding(.bottom, 20)
                NavigationLink(destination: ImportWalletView(viewModel: viewModel), isActive: $showImportWallet) {

                    Button {
                        showImportWallet = true
                    } label: {
                        Text("IMPORT WALLET")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 44,
                        maxHeight: 44,
                        alignment: .center
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.black, lineWidth: 0.5)
                    )
                }
            }
            .padding()
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .top
            )
            .background(.white)
            .navigationBarHidden(true)
        }
    }
}
