//
//  ViewController.swift
//  api_calls
//
//  Created by Vidyadhar V. Thatte on 6/10/15.
//  Copyright (c) 2015 Vidyadhar V Thatte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var session_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let final1 = "http://api.v3.factual.com/t/products-cpg "
        let url2 = NSURL(string: final1);
        let task2 = NSURLSession.sharedSession().dataTaskWithURL(url2!) {(data, response, error) in
        var error: NSError? = nil;
        var jsonObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.allZeros, error: &error);
        self.session_id = (jsonObject as! NSDictionary)["session_id"] as! String;
        println(self.session_id);
        } //viewDidLoad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

