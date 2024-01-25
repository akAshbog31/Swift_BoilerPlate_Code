//
//  Extention+UIviewController.swift
//  Summit
//
//  Created by AKASH on 22/12/22.
//

import UIKit
import IHProgressHUD
import IQKeyboardManagerSwift

//MARK: - ViewController Transitions
extension UIViewController {
    func pushVc(vc: UIViewController?, transition type: CATransitionType = .fade, interval: TimeInterval = 0.3) {
        guard let vc = vc else { return }
        createTransition(transition: type, interval: interval)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popVc(transition type: CATransitionType = .fade, interval: TimeInterval = 0.3) {
        createTransition(transition: type, interval: interval)
        self.navigationController?.popViewController(animated: true)
    }
    
    func createTransition(transition type: CATransitionType = .fade, interval: TimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = interval
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = type
        self.navigationController?.view.layer.add(transition, forKey: nil)
    }
}

//MARK: - Hide/Show Huds
extension UIViewController {
    func showHUD(progressLabel: String = "Loading...", hudColor: UIColor = .label) {
        queue.async {
            IHProgressHUD.set(backgroundColor: .clear)
            IHProgressHUD.setHapticsEnabled(hapticsEnabled: true)
            IHProgressHUD.set(containerView: Globals.keyWindow?.rootViewController?.view)
            IHProgressHUD.set(defaultAnimationType: .flat)
            IHProgressHUD.set(defaultMaskType: .clear)
            IHProgressHUD.set(foregroundColor: hudColor)
            IHProgressHUD.set(ringThickness: 4.asDeviceHeight)
            IHProgressHUD.set(font: .boldSystemFont(ofSize: 17.asDeviceHeight))
            IHProgressHUD.set(ringRadius: 20.asDeviceHeight)
            IHProgressHUD.show(withStatus: progressLabel)
            Globals.keyWindow?.rootViewController?.view.isUserInteractionEnabled = false
        }
    }
    
    func hideHUD() {
        queue.async {
            IHProgressHUD.dismissWithCompletion {
                Globals.keyWindow?.rootViewController?.view.isUserInteractionEnabled = true
            }
        }
    }
}

//MARK: - Show Alerts
extension UIViewController {
    func showAlertWithTitle(title: String = "App", msg: String, options: String..., btnStyle: UIAlertAction.Style..., completion: @escaping ((Int) -> ())) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alert.addAction(UIAlertAction.init(title: option, style: btnStyle[index], handler: { (action) in
                completion(index)
            }))
        }
        var rootViewController = Utils.shared.getSceneDelegate()?.window?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        if let presentedVc = rootViewController?.presentedViewController {
            rootViewController = presentedVc
        }
        rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String = "App", msg: String, buttonText: String? = "OK") {
        self.showAlertWithTitle(title: title,msg: msg, options: buttonText ?? "OK", btnStyle: .default, completion: { option in
            switch option {
            case 0: break
            default: break
            }
        })
    }
    
    func gotoSettingAlert(msg: String) {
        let alert = UIAlertController(title: "WARNING", message: msg, preferredStyle: .alert)
        let gotoSetting = UIAlertAction(title: "Settings", style: .default) { _ in
            let url = URL(string: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:])
            }
        }
        let btnCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(gotoSetting)
        alert.addAction(btnCancel)
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - Check Notification Status
extension UIViewController {
    func checkNotificationsAuthorizationStatus(complition: @escaping (Bool) -> ()) {
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.getNotificationSettings { (notificationSettings) in
            if notificationSettings.authorizationStatus == .authorized {
                complition(true)
            } else {
                complition(false)
            }
        }
    }
}
