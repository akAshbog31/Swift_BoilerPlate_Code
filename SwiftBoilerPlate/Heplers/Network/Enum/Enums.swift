//
//  Enums.swift
//  Squeezee
//
//  Created by iOS Developer on 21/08/23.
//

import Foundation

enum APIError: Error {
    case badRequest
    case invalidURL(urlStr: String)
}

extension APIError: CustomStringConvertible {
    var description: String {
        switch self {
        case .badRequest:
            return "Api request is bad."
        case .invalidURL(let urlStr):
            return "\(urlStr) is invalid url."
        }
    }
}

enum APIMethod: String {
    case get, post, put, patch, delete
}

enum Request {
    case jsonEncoding(_ model: [String: Any]?)
    case queryString(_ dict: [String: Any]?)
    case multiPart(_ dict: [String: Any]?)
    case none
    
    var jsonBody: [String: Any]? {
        switch self {
        case .jsonEncoding(let model):
            return model
        case .queryString, .multiPart, .none: return nil
        }
    }
    
    var queryItem: [URLQueryItem] {
        switch self {
        case .jsonEncoding, .multiPart, .none:
            return []
        case .queryString(let dict):
            return dict?.asQueryParam ?? []
        }
    }
    
    var formData: (Data, String)? {
        switch self {
        case .jsonEncoding, .queryString, .none: return nil
        case .multiPart(let dict):
            return dict?.asMultiPartData()
        }
    }
}
