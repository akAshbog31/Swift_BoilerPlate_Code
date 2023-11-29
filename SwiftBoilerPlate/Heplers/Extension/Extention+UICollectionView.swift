//
//  Extention+UICollectionView.swift
//  Summit
//
//  Created by AKASH on 23/01/23.
//

import Foundation
import UIKit

extension UICollectionView {
    func deque<cell : UICollectionViewCell>(indexPath: IndexPath) -> cell {
        let identifier = String(describing: cell.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? cell
            else { fatalError("=====>Error in cell") }
        return cell
    }
    
    func deque<cell : UICollectionViewCell>(indexPath: IndexPath, kind: String) -> cell {
        let identifier = String(describing: cell.self)
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? cell
            else { fatalError("=====>Error in cell") }
        return cell
    }
    
    func reload() {
        UIView.transition(with: self, duration: 0.35, options: .transitionCrossDissolve) {
            queue.async {
                self.reloadData()
            }
        }
    }
}

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
