//
//  DismissAnimator.swift
//  VideosApp
//
//  Created by Prabhdeep Singh on 30/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit

class DismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration = 0.5
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
     
        let containerView = transitionContext.containerView

//        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
          let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
       
//        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        let toView = transitionContext.viewController(forKey: .to)!.view!

        containerView.insertSubview(toView, belowSubview: fromView)

        UIView.animate(withDuration: duration, delay: 0.0, options: [], animations: {

            fromView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            fromView.center = CGPoint(
                x: self.originFrame.midX,
                y: self.originFrame.midY
            )

        }, completion: {_ in

            transitionContext.completeTransition(true)
           //workaround because lines 27 and 28 are bugged
      UIApplication.shared.keyWindow!.addSubview(transitionContext.viewController(forKey: .to)!.view!)
        })
    }
    

}
