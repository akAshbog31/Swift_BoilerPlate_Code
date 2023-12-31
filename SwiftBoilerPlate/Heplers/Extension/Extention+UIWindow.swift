//
//  Extention+UIWindow.swift
//  SwiftBoilerPlate
//
//  Created by AKASH on 22/11/23.
//

import UIKit

extension UIWindow {
    func switchRootVc(to viewController: UIViewController, animated: Bool = true, duration: TimeInterval = 0.5, options: UIView.AnimationOptions = .transitionCrossDissolve, _ completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            completion?()
            return
        }

        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = UINavigationController(rootViewController: viewController)
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }
}
