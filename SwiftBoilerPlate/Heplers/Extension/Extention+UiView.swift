//
//  Extention+UiView.swift
//  Summit
//
//  Created by AKASH on 22/12/22.
//

import UIKit

public extension UIView {
    @IBInspectable var layerBorderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }

    @IBInspectable var layerBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var layerCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }

    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }

    var isRightToLeft: Bool {
        return effectiveUserInterfaceLayoutDirection == .rightToLeft
    }

    var screenshot: UIImage? {
        let size = layer.frame.size
        guard size != .zero else { return nil }
        return UIGraphicsImageRenderer(size: layer.frame.size).image { context in
            layer.render(in: context.cgContext)
        }
    }

    @IBInspectable var layerShadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable var layerShadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable var layerShadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var layerShadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }

    var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }

    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }

    var xPosition: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }

    var yPosition: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
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

public extension UIView {
    struct GradientDirection {
        public static let topToBottom = GradientDirection(startPoint: CGPoint(x: 0.5, y: 0.0),
                                                          endPoint: CGPoint(x: 0.5, y: 1.0))
        public static let bottomToTop = GradientDirection(startPoint: CGPoint(x: 0.5, y: 1.0),
                                                          endPoint: CGPoint(x: 0.5, y: 0.0))
        public static let leftToRight = GradientDirection(startPoint: CGPoint(x: 0.0, y: 0.5),
                                                          endPoint: CGPoint(x: 1.0, y: 0.5))
        public static let rightToLeft = GradientDirection(startPoint: CGPoint(x: 1.0, y: 0.5),
                                                          endPoint: CGPoint(x: 0.0, y: 0.5))

        public let startPoint: CGPoint
        public let endPoint: CGPoint

        public init(startPoint: CGPoint, endPoint: CGPoint) {
            self.startPoint = startPoint
            self.endPoint = endPoint
        }
    }
}

extension UIView {
    func addGradient(colors: [UIColor], locations: [CGFloat] = [0.0, 1.0], direction: GradientDirection) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map(\.cgColor)
        gradientLayer.locations = locations.map { NSNumber(value: $0) }
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint
        layer.addSublayer(gradientLayer)
    }

    func addShadow(ofColor color: UIColor = .gray,
                   radius: CGFloat = 3,
                   offset: CGSize = .zero,
                   opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
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
