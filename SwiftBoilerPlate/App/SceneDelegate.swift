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

extension SceneDelegate {
    func setRootVc(vc: VCType) {
        guard let logInVc = R.storyboard.main.viewController() else { return }
        
        switch vc {
        case .main:
            window?.rootViewController = UINavigationController(rootViewController: logInVc)
        }
        
        window?.makeKeyAndVisible()
    }
}

enum VCType {
    case main
}

