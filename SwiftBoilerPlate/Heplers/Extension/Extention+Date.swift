//
//  Extention+Date.swift
//  Summit
//
//  Created by AKASH on 02/02/23.
//

import UIKit

extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }
}
