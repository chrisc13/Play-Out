//
//  scaleSegue.swift
//  Play Out
//
//  Created by Chris Carbajal on 5/21/19.
//  Copyright © 2019 Chris Carbajal. All rights reserved.
//

import UIKit

class scaleSegue: UIStoryboardSegue {

    override func perform() {
        scale()
    }
    func scale(){
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let originalcenter = fromViewController.view.center
        
        toViewController.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        toViewController.view.center = originalcenter
        
        containerView?.addSubview(toViewController.view)
        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionFlipFromBottom, animations:{ toViewController.view.transform = CGAffineTransform.identity}, completion: {success in fromViewController.present(toViewController, animated: false, completion: nil)
            
        })
        
    }
    
}
class unwindScaleSegue: UIStoryboardSegue{
    override func perform() {
        scale()
    }
    func scale(){
        let toViewController = self.destination
        let fromViewController = self.source
        fromViewController.view.superview?.insertSubview(toViewController.view , at: 0)
        
        UIView.animate(withDuration: 0.0001, delay: 0, options:.layoutSubviews, animations:{ fromViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)}, completion: {success in fromViewController.dismiss(animated: false, completion: nil)
            
            
        })
        
    }

}
