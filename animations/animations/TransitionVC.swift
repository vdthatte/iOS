//
//  TransitionVC.swift
//  animations
//
//  Created by Vidyadhar V. Thatte on 5/21/15.
//  Copyright (c) 2015 Vidyadhar V Thatte. All rights reserved.
//

import UIKit

class TransitionVC: UIViewController {
    
    let transitionManager = TransitionManager()
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let toViewController = segue.destinationViewController as! UIViewController
        toViewController.transitioningDelegate = self.transitionManager
    }
    
}
