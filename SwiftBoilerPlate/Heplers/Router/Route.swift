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
            return MainVc(viewModel: MainVm())
        case .second:
            return SecondVc(viewModel: SecondVm())
        case .third:
            return ThirdVc(viewModel: ThirdVm())
        }
    }
}
