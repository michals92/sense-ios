//
//  ImportWalletView.swift
//  sense-ios
//
//  Created by Michal Šimík on 03.03.2022.
//

import SwiftUI
import Introspect

struct ImportWalletView: View {
    private enum Field: Int, Hashable {
        case main
    }

    @ObservedObject var viewModel: MainViewModel
    @State private var placeholderText = "Enter your seed phrase..."
    @State private var seedText = ""
    @State private var enableFaceID: Bool = true
    @FocusState private var textFieldFocused: Field?

    var textEditor: some View {
        ZStack {
            if seedText.isEmpty {
                TextEditor(text: $placeholderText)
                    .introspectTextView(customize: { textView in
                        textView.backgroundColor = .clear
                    })
                    .focused($textFieldFocused, equals: .main)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .background(.clear)
                    .disabled(true)
                    .padding()
            }
            TextEditor(text: $seedText)
                .introspectTextView(customize: { textView in
                    textView.backgroundColor = .clear
                })
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(.system(size: 13))
                .opacity(self.seedText.isEmpty ? 0.25 : 1)
                .padding()
                .background(.clear)

        }.background(.clear)
    }

    var body: some View {
        VStack {
            Text("Import ").font(.system(size: 25)) +
            Text("wallet ").font(.system(size: 25, weight: .bold)) +
            Text("using seed ").font(.system(size: 25)) +
            Text("phrase").font(.system(size: 25, weight: .bold))
            textEditor
                .background(Color(uiColor: UIColor(hex: "#F7F7F7") ?? .white))
            Toggle("Enable FaceID", isOn: $enableFaceID)
                .font(.system(size: 13))
            Spacer()
            Button {
                print("import wallet tapped")
                viewModel.saveAccount(phrase: seedText)
            } label: {
                Text("IMPORT")
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
        .padding()
        .navigationBarHidden(true)
        .onAppear {
            textFieldFocused = .main
        }
    }

    private func hideKeyboardAndSave() {
        UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
        print("show keyboard")
    }
}
