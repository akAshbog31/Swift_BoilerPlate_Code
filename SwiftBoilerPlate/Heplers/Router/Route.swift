//
//  Route.swift
//  SwiftBoilerPlate
//
//  Created by AKASH BOGHANI on 10/03/24.
//

import UIKit

// MARK: - Route
enum Route {
    case main
    case second
    case third
}

extension Route {
    var viewController: UIViewController {
        switch self {
        case .main:
            guard let vc = R.storyboard.main.mainVc() else { return .init() }
            return vc
        case .second:
            guard let vc = R.storyboard.main.mainVc() else { return .init() }
            return vc
        case .third:
            guard let vc = R.storyboard.main.mainVc() else { return .init() }
            return vc
        }
    }
}
