//
//  ModalTransition.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 21/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

enum ModalTransitionStep {
    case Push
    case Pop
}

enum ModalTransitionDirection {
    case Right
    case Bottom
}


let ScaleFactor:CGFloat =   0.95

class ModalTransition: NSObject,UIViewControllerAnimatedTransitioning
{
    var transitionStep  :ModalTransitionStep!
    
    
    
    private var duration:NSTimeInterval!
    private var direction:ModalTransitionDirection!
    
    private var opaqueLayer :UIView =   {
        
        let view                =   UIView()
        view.backgroundColor    =   UIColor.blackColor()
        view.alpha              =   0.0
        
        return view
    }()
    
    convenience init( direction modalTransitionDirection:ModalTransitionDirection, transtitionDuration:NSTimeInterval)
    {
        self.init()
        
        
        self.duration   =   transtitionDuration
        self.direction  =   modalTransitionDirection
    }
    
    
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.duration
    }
    
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        let fromVC          =   transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC            =   transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let containerView   =   transitionContext.containerView()!
        let bounds          =   containerView.frame
        
        var dismissFrame    =   CGRectMake(0.0, 0.0, bounds.width, bounds.maxY)
        var presentFrame    =   containerView.frame
        
        
        var transform3D      =   CATransform3DIdentity
        transform3D.m34      =   1.0 / -900
        transform3D          =   CATransform3DScale(transform3D, ScaleFactor, ScaleFactor, 1.0)
        
        
        
        self.opaqueLayer.frame  =  bounds
        
        if self.transitionStep == .Push
        {
            
            if self.direction == .Right {
                presentFrame.origin.x =   bounds.width
            }
            else
            {
                presentFrame.origin.y =   bounds.height
            }
            
            
            fromVC.view.addSubview(self.opaqueLayer)
            
            toVC.view.frame             =   presentFrame
            
            containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
            
            fromVC.view.setNeedsLayout()
            
            UIView.animateWithDuration(self.duration, delay: 0.0, options: .CurveEaseOut, animations: {
                
                fromVC.view.layer.transform =   transform3D
                
                self.opaqueLayer.alpha      =   0.85
                toVC.view.frame             =   bounds
                
                }, completion: { (finished:Bool) in
                    
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
            
        }
        else
        {
            
            if self.direction == .Right {
                dismissFrame.origin.x =   bounds.width
            }
            else
            {
                dismissFrame.origin.y =   bounds.height
            }
            
            
            toVC.view.layer.transform =   transform3D
            toVC.view.setNeedsLayout()
            
            UIView.animateWithDuration(self.duration, delay: 0.0, options: .CurveEaseOut, animations: {
                
                toVC.view.layer.transform   =   CATransform3DIdentity
                self.opaqueLayer.alpha      =   0.0
                fromVC.view.frame           =   dismissFrame
                
                }, completion: { (finished:Bool) in
                    
                    if finished
                    {
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                        
                        self.opaqueLayer.removeFromSuperview()
                    }
            })
            
        }
        
    }


}
