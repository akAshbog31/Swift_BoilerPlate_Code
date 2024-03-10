//
//  MainModel.swift
//  BoilerPlate
//
//  Created by AKASH on 21/11/23.
//

import Foundation

// MARK: - GenralResponseModel
struct GenralResponseModel<T: Codable>: Codable {
    let success: Bool?
    let message: String?
    let data: T?
}

// MARK: - UpdateProfilePostModel
struct UpdateProfilePostModel: Codable {
    let name: String?
    var notes: String? = ""
    var dateOfBirth: String? = ""
    let profileImage: Data?

    enum CodingKeys: String, CodingKey {
        case name, notes
        case dateOfBirth = "date_of_birth"
        case profileImage = "profile_image"
    }
}

// MARK: - User
struct User: Codable {
    let profileImage: String?
    let id: Int?
    let name: String?
    let countryCode: String?
    let phoneNumber: Int?
    let email: String?
    let socialID, socialProvider, password, notes, dateOfBirth, createdAt: String?
    let isActive: Bool?
    let updatedAt: String?
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
        case id, name
        case countryCode = "country_code"
        case phoneNumber = "phone_number"
        case email
        case socialID = "social_id"
        case socialProvider = "social_provider"
        case password, notes
        case dateOfBirth = "date_of_birth"
        case createdAt
        case isActive = "is_active"
        case updatedAt, deletedAt
    }
}
