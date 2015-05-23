//
//  TransitionVC.swift
//  animations
//
//  Created by Vidyadhar V. Thatte on 5/21/15.
//  Copyright (c) 2015 Vidyadhar V Thatte. All rights reserved.
//

import UIKit

class TransitionVC: UIViewController {
    var theBool = true
    let transitionManager = TransitionManager()
    let trans = TransitionManager2() // up and down
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
    }
    
    @IBAction func show(sender: AnyObject) {
        
    }
    @IBAction func button(sender: AnyObject) {
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let toViewController = segue.destinationViewController as! UIViewController
            toViewController.transitioningDelegate = self.transitionManager
/*
            let toViewController = segue.destinationViewController as! UIViewController
            toViewController.transitioningDelegate = self.trans
*/
    }
    
}
