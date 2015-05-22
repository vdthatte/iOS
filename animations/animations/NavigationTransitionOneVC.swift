//
//  NavigationTransitionOneVC.swift
//  animations
//
//  Created by Vidyadhar V. Thatte on 5/21/15.
//  Copyright (c) 2015 Vidyadhar V Thatte. All rights reserved.
//

import UIKit

class NavigationTransitionOneVC: UIViewController {
    @IBAction func unWindToMainViewController( sender: UIStoryboardSegue ){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
