//
//  NetworkManager.swift
//  Squeezee
//
//  Created by AKASH on 04/08/23.
//

import Foundation

final class NetworkManager: NetworkService {
    func updateProfile(model: UpdateProfilePostModel) async throws -> GenralResponseModel<User> {
        try await APIService.request(API.updateProfile(model: model))
    }
}
