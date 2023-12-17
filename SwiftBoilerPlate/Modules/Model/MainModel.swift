//
//  MainModel.swift
//  BoilerPlate
//
//  Created by AKASH on 21/11/23.
//

import Foundation

//MARK: - GenralResponseModel
struct GenralResponseModel<T: Codable>: Codable {
    let success: Bool?
    let message: String?
    let data: T?
}

// MARK: - UpdateProfilePostModel
struct UpdateProfilePostModel: Codable {
    let name: String?
    var notes: String? = nil
    var date_of_birth: String? = nil
    let profile_image: Data?
}

// MARK: - User
struct User: Codable {
    let profile_image: String?
    let id: Int?
    let name: String?
    let country_code: String?
    let phone_number: Int?
    let email: String?
    let social_id, social_provider, password, notes, date_of_birth, createdAt: String?
    let is_active: Bool?
    let updatedAt: String?
    let deletedAt: String?
}
