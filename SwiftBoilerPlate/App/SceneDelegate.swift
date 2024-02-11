//
//  SceneDelegate.swift
//  BoilerPlate
//
//  Created by AKASH on 21/11/23.
//

import UIKit

// MARK: - SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo _: UISceneSession,
               options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        window = UIWindow(windowScene: windowScene)
        setRootVc(viewController: .main)
    }
}

// MARK: - Extension SceneDelegate
extension SceneDelegate {
    func setRootVc(viewController: VCType,
                   animated: Bool = true,
                   duration: TimeInterval = 0.5,
                   options: UIView.AnimationOptions = .transitionCrossDissolve,
                   _ completion: (() -> Void)? = nil) {
        guard let logInVc = R.storyboard.main.viewController() else {
            return
        }

        switch viewController {
        case .main:
            window?.switchRootVc(to: logInVc, animated: animated, duration: duration, options: options, completion)
        }

        window?.makeKeyAndVisible()
    }
}

// MARK: - VCType
enum VCType {
    case main
}
