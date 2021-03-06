//
//  CircleView.swift
//  AnimationsTransitionsAndDrawing
//
//  Created by Felipe Lefèvre Marino on 12/7/17.
//  Copyright © 2017 Felipe Lefèvre Marino. All rights reserved.
//

import UIKit

@objc protocol CustomizedView {
    @objc optional var imageTintColor: UIColor? { get set }
    var borderWidth: CGFloat { get set }
    var borderColor: UIColor { get set }
    var cornerRadius: CGFloat { get set }
}

@IBDesignable
class CircleImageView: UIImageView, CustomizedView {
    
    @IBInspectable var imageTintColor: UIColor? {
        didSet {
            image = self.image?.withRenderingMode(.alwaysTemplate)
            tintColor = imageTintColor
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
}

@IBDesignable
class BorderedUIView: UIView, CustomizedView {
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
    
    override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 10, y: 0), size: CGSize(width: bounds.width - 20, height: bounds.height - 2)), cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.5
        layer.shadowPath = shadowPath.cgPath
        super.layoutSubviews()
    }
}

@IBDesignable
class CorneredProgressView: UIProgressView {
    
    fileprivate var didAnimate: Bool = false
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            clipsToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
    
    internal func animate(toProgress: Float) {
        if !didAnimate {
            didAnimate = true
            if toProgress > 0.0 {
                setProgress(toProgress, animated: true)
            }
        }
    }
}

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
}
