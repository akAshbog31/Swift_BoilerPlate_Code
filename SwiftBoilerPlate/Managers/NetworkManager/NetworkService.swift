//
//  NetworkService.swift
//  Squeezee
//
//  Created by AKASH on 04/08/23.
//

import Foundation

protocol NetworkService {
    func testAPI() async throws -> SampleModel
}
