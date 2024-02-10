//
//  AppDelegate.swift
//  BoilerPlate
//
//  Created by AKASH on 21/11/23.
//

// MARK: - Project Configure
    /// 1. When open project first time `Build` it once to remove `R` not found error.
    /// 2. Add `SwiftLint` globaly using `brew install swiftlint` command. ( Ref: -https://github.com/realm/SwiftLint.git )

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        return true
    }
}
