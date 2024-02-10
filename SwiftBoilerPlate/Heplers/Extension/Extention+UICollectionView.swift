//
//  Extention+UICollectionView.swift
//  Summit
//
//  Created by AKASH on 23/01/23.
//

import Foundation
import UIKit

extension UICollectionView {
    func deque<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell
        else { fatalError("=====>Error in cell") }
        return cell
    }

    func deque<Cell: UICollectionViewCell>(indexPath: IndexPath, kind: String) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: kind,
                                                               withReuseIdentifier: identifier,
                                                               for: indexPath) as? Cell
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
