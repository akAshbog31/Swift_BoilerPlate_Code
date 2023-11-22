//
//  Ext.swift
//  Squeezee
//
//  Created by iOS Developer on 21/08/23.
//

import Foundation

extension Encodable {
    var asDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension Dictionary where Key == String {
    var asQueryParam: [URLQueryItem] {
        return self.compactMap { key, value in
            let stringValue: String
            if let stringConvertible = value as? CustomStringConvertible {
                stringValue = stringConvertible.description
            } else {
                return nil
            }
            return URLQueryItem(name: key, value: stringValue)
        }
    }
    
    func asMultiPartData() -> (Data, String) {
        var formData = Data()
        let boundary = "-----------------------------\(UUID().uuidString)"
        let lineBreak = "\r\n"
        
        for (key, value) in self {
            convertToMultipartFormData(key: key, value: value, boundary: boundary, formData: &formData)
        }

        formData.append("--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
        return (formData, boundary)
    }

    private func convertToMultipartFormData(key: String, value: Any, boundary: String, formData: inout Data) {
        if let stringValue = value as? CustomStringConvertible {
            if let data = stringValue.description.data(using: .utf8) {
                formData.append("--\(boundary)\r\n".data(using: .utf8)!)
                formData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                formData.append(data)
                formData.append("\r\n".data(using: .utf8)!)
            }
        } else if let imageData = value as? Data {
            let mimeType = "image/jpeg"
            formData.append("--\(boundary)\r\n".data(using: .utf8)!)
            formData.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(key).jpeg\"\r\n".data(using: .utf8)!)
            formData.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
            formData.append(imageData)
            formData.append("\r\n".data(using: .utf8)!)
        } else if let dictionaryValue = value as? [String: Any] {
            for (nestedKey, nestedValue) in dictionaryValue {
                convertToMultipartFormData(key: "\(key)[\(nestedKey)]", value: nestedValue, boundary: boundary, formData: &formData)
            }
        }
    }
}


extension URLRequest {
    public var curlString: String {
        guard let url = url else { return "" }
        var baseCommand = #"curl "\#(url.absoluteString)""#

        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }
        var command = [baseCommand]
        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }
        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }
        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }
        return command.joined(separator: " \\\n\t")
    }
}
