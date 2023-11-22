//
//  Extention+UIviewController.swift
//  Summit
//
//  Created by AKASH on 22/12/22.
//

import UIKit
import MBProgressHUD
import IQKeyboardManagerSwift


extension UIViewController {
    func pushVc(vc: UIViewController?) {
        guard let vc = vc else { return }
        self.navigationController?.pushViewController(vc)
    }
    
    func popVc() {
        self.navigationController?.popViewController()
    }
    
    func showHUD(progressLabel: String = "Loading...") {
        DispatchQueue.main.async {
            let progressHUD = MBProgressHUD.showAdded(to: (Utils.shared.getSceneDelegate()?.window)!, animated: true)
            progressHUD.label.text = progressLabel
            progressHUD.bezelView.layer.cornerRadius = Globals.getValueAsPerDeviceHeight(18)
            progressHUD.bezelView.blurEffectStyle = .systemChromeMaterialDark
            progressHUD.contentColor = .systemBackground
            progressHUD.bezelView.style = .blur
        }
    }
    
    func dismissHUD(isAnimated: Bool = true) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: (Utils.shared.getSceneDelegate()?.window)!, animated: isAnimated)
        }
    }
    
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
