//
//  API.swift
//  Squeezee
//
//  Created by AKASH on 04/08/23.
//

import Foundation

// MARK: - API
enum API {
    case updateProfile(model: UpdateProfilePostModel)
}

// MARK: - APIProtocol
extension API: APIProtocol {
    var baseURL: String {
        "http://35.154.65.40:3030/api/v1/"
    }

    var path: String {
        switch self {
        case .updateProfile:
            return "user/update-profile"
        }
    }

    var method: APIMethod {
        switch self {
        case .updateProfile:
            return .patch
        }
    }

    var task: Request {
        switch self {
        case let .updateProfile(model):
            var mutliPartFormData = MultipartRequest()
            mutliPartFormData.add(key: "name", value: model.name ?? "")
            mutliPartFormData.add(key: "date_of_birth", value: model.dateOfBirth ?? "")
            mutliPartFormData.add(key: "notes", value: model.notes ?? "")
            mutliPartFormData.add(key: "profile_image",
                                  fileName: "\(UUID().uuidString).jpeg",
                                  fileMimeType: "image/jpeg",
                                  fileData: model.profileImage ?? Data())
            return .multiPart(mutliPartFormData)
        }
    }

    var header: [String: String] {
        switch self {
        case .updateProfile:
            return [
                "Authorization": "260DJKzEpojzElPlnc9i2pwshXZsmF83MvdmesfIcJglLSyVYes4eqT58v2GdmQ2IdQrKTbLPEdvqicxgVzkxuymQDTrvGwIihuEJDVCWq7JH"
            ]
        }
    }
}
