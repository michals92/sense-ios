//
//  AppDelegate.swift
//  sense-ios
//
//  Created by Michal Šimík on 03.03.2022.
//

// swiftlint:disable line_length

import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        FirebaseApp.configure()
        return true
    }
}
