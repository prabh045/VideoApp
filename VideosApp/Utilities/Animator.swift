//
//  Animator.swift
//  VideosApp
//
//  Created by Prabhdeep Singh on 30/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration = 0.5
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        let finalFrame = toView.frame
        
        let xScaleFactor = originFrame.width / finalFrame.width
        let yScaleFactor = originFrame.height / finalFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        toView.transform = scaleTransform
        toView.center = CGPoint(
            x: originFrame.midX,
            y: originFrame.midY
        )
        
        toView.clipsToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(toView)
        
        UIView.animate(withDuration: duration, delay: 0.0,
                       options: [], animations: {
                        toView.transform = CGAffineTransform.identity
                        toView.center = CGPoint(
                            x: finalFrame.midX,
                            y: finalFrame.midY
                        )
                        
        }, completion: {_ in
            transitionContext.completeTransition(
                !transitionContext.transitionWasCancelled
            )
        })
    }
    
    //    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    //        let containerView = transitionContext.containerView
    //        let toView = transitionContext.view(forKey: .to)!
    //        containerView.addSubview(toView)
    //        toView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    //        UIView.animate(
    //          withDuration: duration,
    //          animations: {
    //            toView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    //          },
    //          completion: { _ in
    //            transitionContext.completeTransition(true)
    //          }
    //        )
    //    }
    
    
}
