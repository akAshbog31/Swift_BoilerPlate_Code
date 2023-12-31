//
//  Globals.swift
//  Squeezee
//
//  Created by AKASH on 19/09/23.
//

import Foundation
import UIKit
import Combine

//MARK: - TypeAlice
typealias TaskBag = Set<TaskCancellables>
typealias Bag = Set<AnyCancellable>
typealias AppSubject<T> = PassthroughSubject<T, Never>
typealias AppAnyPublisher<T> = AnyPublisher<T, Never>

//MARK: - Public Valriable
public let queue = DispatchQueue.main

//MARK: - Globals
enum Globals {
    //MARK: - Values With Decive Size
    static func getValueAsPerDeviceWidth(_ newValue: CGFloat) -> CGFloat {
        let size = CGFloat(newValue) * UIScreen.main.bounds.size.width / 430
        return size
    }
    
    static func getValueAsPerDeviceHeight(_ newValue: CGFloat) -> CGFloat {
        let size = CGFloat(newValue) * UIScreen.main.bounds.size.height / 812
        return size
    }
    
    //MARK: - Key Window
    static var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.last
    }
}

//MARK: - ValidationError
enum ValidationError: Error {
    case empty(type: String)
    case inValidEmailOrPhonenumber
    case inValidPassword
    case conformPaaswordNotMatch
    case inValidOtpCount
}

extension ValidationError: CustomStringConvertible {
    var description: String {
        switch self {
        case .empty(let type):
            return "\(type) must not empty."
        case .inValidEmailOrPhonenumber:
            return "Email/Phone number is not valid."
        case .inValidPassword:
            return "Password length must be 8 and it should contain uppercase character, lowercase character and symbols."
        case .conformPaaswordNotMatch:
            return "Conform password not match with password."
        case .inValidOtpCount:
            return "OTP length must be 4."
        }
    }
}

//MARK: - AppError
enum AppError: Error {
    case inValidURL
}

extension AppError: CustomStringConvertible {
    var description: String {
        switch self {
        case .inValidURL:
            return "URL not valid."
        }
    }
}
