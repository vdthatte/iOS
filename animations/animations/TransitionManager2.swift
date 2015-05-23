//
//  TransitionManager2.swift
//  animations
//
//  Created by Vidyadhar V. Thatte on 5/21/15.
//  Copyright (c) 2015 Vidyadhar V Thatte. All rights reserved.
//

import UIKit

class TransitionManager2:  NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var pre : Bool = false
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        pre = true
        return self
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        pre = false
        return self
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let offScreenTop = CGAffineTransformMakeTranslation(0, container.frame.height )
        let offScreenBottom = CGAffineTransformMakeTranslation(0, -container.frame.height )
        let offScreenRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
        let offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)
        
        if(pre == true){
            toView.transform = offScreenTop
            
            container.addSubview(toView)
            container.addSubview(fromView)
            
            let duration = self.transitionDuration(transitionContext)
            
            UIView.animateWithDuration(duration, animations: {
                fromView.transform = offScreenBottom
                toView.transform = CGAffineTransformIdentity
                
                }, completion: { finished in
                    
                    // tell our transitionContext object that we've finished animating
                    transitionContext.completeTransition(true)
            })
        }
        else{
            toView.transform = offScreenBottom
            
            container.addSubview(toView)
            container.addSubview(fromView)
            
            let duration = self.transitionDuration(transitionContext)
            
            UIView.animateWithDuration(duration, animations: {
                fromView.transform = offScreenTop
                toView.transform = CGAffineTransformIdentity
                
                }, completion: { finished in
                    
                    // tell our transitionContext object that we've finished animating
                    transitionContext.completeTransition(true)
            })
        }
        
    }
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.4
    }
    
    
}