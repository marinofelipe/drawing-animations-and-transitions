//
//  DonutChart.swift
//  AnimationsTransitionsAndDrawing
//
//  Created by Felipe Lefèvre Marino on 12/8/17.
//  Copyright © 2017 Felipe Lefèvre Marino. All rights reserved.
//

import UIKit

@IBDesignable
class DonutChart: UIView {
    
    @IBInspectable var progress: CGFloat = 0
    @IBInspectable var width: CGFloat = 0
    @IBInspectable var centerColor: UIColor = .white
    @IBInspectable var emptyColor: UIColor = .groupTableViewBackground
    @IBInspectable var filledColor: UIColor = UIColor.green
    fileprivate var progressLayer = CAShapeLayer()
    fileprivate lazy var filledArc = UIBezierPath()
    fileprivate var didAnimate: Bool = false
    
    // MARK: Drawing
    override func draw(_ rect: CGRect) {
        let circle = UIBezierPath(ovalIn: rect)
        centerColor.setFill()
        circle.fill()

        let emptyArc = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2),
                                         radius: bounds.width/2 - width/2,
                                         startAngle: 0,
                                         endAngle: 2 * .pi,
                                         clockwise: true)
        emptyArc.lineWidth = width
        emptyArc.lineCapStyle = .round
        emptyColor.setStroke()
        emptyArc.stroke()
        
        setFilledArc()
        animateProgress(with: filledArc)
    }
    
    private func animateProgress(with arc: UIBezierPath) {
        progressLayer.strokeColor = filledColor.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = width
        progressLayer.path = arc.cgPath
        
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 1.0
        
        self.layer.addSublayer(progressLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.0
        
        progressLayer.add(animation, forKey: "drawLineAnimation")
    }
    
    // MARK: Functions
    //to be used in case the animation won't be sarted at drawing   
    internal func animateProgress() {
        if !didAnimate {
            didAnimate = true
            setFilledArc()
            animateProgress(with: filledArc)
        }
    }
    
    internal func setFilledArc() {
        filledArc = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2),
                                 radius: bounds.width/2 - width/2,
                                 startAngle: 3 * .pi / 2,
                                 endAngle: 3 * .pi / 2 + progress * 2 * .pi,
                                 clockwise: true)
        filledArc.lineWidth = width
        filledArc.lineCapStyle = .round
    }
}
