//
//  Extention+DispatchQueue.swift
//  SwiftBoilerPlate
//
//  Created by AKASH BOGHANI on 28/11/23.
//

import Foundation

extension DispatchQueue {
    public func after(time interval: TimeInterval, work: @escaping () -> Void) {
        asyncAfter(deadline: .now() + interval) {
            work()
        }
    }
}
