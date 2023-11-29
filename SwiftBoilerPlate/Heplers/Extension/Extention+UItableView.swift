//
//  Extention+UItableView.swift
//  Summit
//
//  Created by AKASH on 17/01/23.
//

import Foundation
import UIKit

extension UITableView {
    func deque<cell : UITableViewCell>() -> cell {
        let identifier = String(describing: cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? cell
            else {fatalError("=====>Error in cell") }
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
