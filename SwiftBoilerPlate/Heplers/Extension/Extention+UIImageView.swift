//
//  Extention+UIImageView.swift
//  Squeezee
//
//  Created by AKASH on 07/08/23.
//

import UIKit
import SDWebImage

extension UIImageView {
    @discardableResult
    func setImage(from urlStr: String, placeholderImage: UIImage) async throws -> UIImage? {
        return try await withCheckedThrowingContinuation { continuation in
            guard let url = URL(string: urlStr) else { continuation.resume(throwing: AppError.inValidURL); return }
            self.sd_setImage(with: url, placeholderImage: placeholderImage) { img, error, _, _ in
                if let error = error {
                    continuation.resume(throwing: error)
                }
                continuation.resume(returning: img)
            }
        }
    }
    
    @MainActor
    func setImage(from urlStr: String, placeholderImage: UIImage) throws {
        Task {
            try await self.setImage(from: urlStr, placeholderImage: placeholderImage)
        }
    }
}
