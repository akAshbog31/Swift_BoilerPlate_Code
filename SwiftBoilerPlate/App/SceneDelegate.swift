//
//  SceneDelegate.swift
//  BoilerPlate
//
//  Created by AKASH on 21/11/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        setRootVc(vc: .main)
    }
}

//MARK: - Extension SceneDelegate
extension SceneDelegate {
    func setRootVc(vc: VCType, animated: Bool = true, duration: TimeInterval = 0.5, options: UIView.AnimationOptions = .transitionCrossDissolve, _ completion: (() -> Void)? = nil) {
        guard let logInVc = R.storyboard.main.viewController() else { return }
        
        switch vc {
        case .main:
            window?.switchRootVc(to: logInVc, animated: animated, duration: duration, options: options, completion)
        }
        
        window?.makeKeyAndVisible()
    }
}

//MARK: - Enum VCType
enum VCType {
    case main
}

