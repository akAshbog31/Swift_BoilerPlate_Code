//
//  Extention+UiView.swift
//  Summit
//
//  Created by AKASH on 22/12/22.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            let radius = newValue * UIScreen.main.bounds.size.height / 812
            layer.shadowRadius = radius
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

@IBDesignable
extension UILabel {
    @IBInspectable
    var dynamicFontSize: CGFloat {
        get {
            return self.dynamicFontSize
        }
        set {
            let size = newValue * UIScreen.main.bounds.size.width / 430
            font = UIFont(name: font.fontName, size: size)
        }
    }
}

@IBDesignable
extension UIButton {
    @IBInspectable
    var dynamicFontSize: CGFloat {
        get {
            return self.dynamicFontSize
        }
        set {
            let size = newValue * UIScreen.main.bounds.size.width / 430
            titleLabel?.font = UIFont(name: titleLabel?.font.fontName ?? "", size: size)
        }
    }
}

@IBDesignable
extension UITextField {
    @IBInspectable
    var dynamicFontSize: CGFloat {
        get {
            return self.dynamicFontSize
        }
        set {
            let size = newValue * UIScreen.main.bounds.size.width / 430
            font = UIFont(name: font?.fontName ?? "", size: size)
        }
    }
}

@IBDesignable
extension UITextView {
    @IBInspectable
    var dynamicFontSize: CGFloat {
        get {
            return self.dynamicFontSize
        }
        set {
            let size = newValue * UIScreen.main.bounds.size.width / 430
            font = UIFont(name: font?.fontName ?? "", size: size)
        }
    }
}

extension UIView {
    func applyGradient(isVertical: Bool, colorArray: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
            gradientLayer.locations = [0.0, 1.0]
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        backgroundColor = .clear
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func dropShadow(scale: Bool = true, shadowOffSet: CGSize = .zero, shadowOpacity: Float, shadowRadius: CGFloat, shadowColor: CGColor) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffSet
        layer.shadowRadius = shadowRadius
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension UIView {
    func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview.map { $0.superview(of: type)! }
    }
    
    func subview<T>(of type: T.Type) -> T? {
        return subviews.compactMap { $0 as? T ?? $0.subview(of: type) }.first
    }
}
