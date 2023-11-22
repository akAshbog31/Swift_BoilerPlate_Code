//
//  API.swift
//  Squeezee
//
//  Created by AKASH on 04/08/23.
//

import Foundation

enum API {
    case yourAPI
}

extension API: APIProtocol {
    var baseURL: String {
        return "Your Base Url"
    }
    
    var path: String {
        switch self {
        case .yourAPI:
            return "/end point"
        }
    }
    
    var method: APIMethod {
        switch self { 
        case .yourAPI:
            return .get
        }
    }
    
    var task: Request {
        switch self {
        case .yourAPI:
            return .none
        }
    }
    
    var header: [String : String] {
        switch self {
        case .yourAPI:
            return ["":""]
        }
    }
}
