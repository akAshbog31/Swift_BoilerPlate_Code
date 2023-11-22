//
//  NetworkManager.swift
//  Squeezee
//
//  Created by AKASH on 04/08/23.
//

import Foundation

final class NetworkManager: NetworkService {
    func testAPI() async throws -> SampleModel {
        return try await APIService.request(API.yourAPI)
    }
}
