//
//  ViewController.swift
//  API_Moya
//
//  Created by admin on 10.08.15.
//  Copyright (c) 2015 brocoders. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    var token: String!

    @IBOutlet weak var textView: UITextView!
    //MARK: UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Post
    @IBAction func post(sender: AnyObject) {
        getToken()
    }
    // MARK: - Get Token
    func getToken() {
        KedzohProvider.request(.Login, completion: {(data, status, resonse, error) -> () in
            var success = error == nil
            if let data = data {
                let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
                if let json: AnyObject = json {
                    let kedzohJson = JSON(json)
                    self.token = kedzohJson["auth_token"].stringValue
                } else {
                    success = false
                }
                self.textView.text = self.token
            } else {
                success = false
            }
            
            if !success {
                let alertController = UIAlertController(title: "GitHub Fetch", message: error?.description, preferredStyle: .Alert)
                let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    alertController.dismissViewControllerAnimated(true, completion: nil)
                })
                alertController.addAction(ok)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        })
    }
}

