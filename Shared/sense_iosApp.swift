//
//  sense_iosApp.swift
//  Shared
//
//  Created by Michal Šimík on 01.03.2022.
//

import SwiftUI
import Firebase

// swiftlint:disable type_name
@main
struct sense_iosApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var viewModel = MainViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if viewModel.account != nil {
                ContentView(viewModel: viewModel)
            } else {
                OnboardingView(viewModel: viewModel)
            }
        }
    }
}
