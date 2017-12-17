//
//  CircleAnimatedController.swift
//  AnimationsTransitionsAndDrawing
//
//  Created by Felipe Lefèvre Marino on 12/17/17.
//  Copyright © 2017 Felipe Lefèvre Marino. All rights reserved.
//

import Foundation
import UIKit

class CircleAnimatedTransitionController: NSObject {
    
    var circle = UIView()
    var startingPoint = CGPoint.zero
    var circleColor = UIColor.white
    var duration = 0.466
    
    enum CircularTransitionMode: Int {
        case present, dismiss, pop
    }
    var transitionMode: CircularTransitionMode = .present
}

extension CircleAnimatedTransitionController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                circle.frame = frameForCircle(withViewCenter: viewCenter, viewSize: viewSize, startingPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = .identity
                    containerView.transform = .identity
                    presentedView.transform = .identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                }, completion: { success in
                    presentedView.frame = UIScreen.main.bounds
                    transitionContext.completeTransition(success)
                })
            }
        } else {
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, viewSize: viewSize, startingPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.alpha = 0
                    returningView.center = self.startingPoint
                    
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: returningView)
                    }
                }, completion: { success in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                })
            }
        }
    }
    
    private func frameForCircle(withViewCenter viewCenter: CGPoint, viewSize size: CGSize, startingPoint: CGPoint) -> CGRect {
        let xLength = fmax(viewCenter.x, size.width - startingPoint.x)
        let yLength = fmax(viewCenter.y, size.height - startingPoint.y)
        
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2.5
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
}
