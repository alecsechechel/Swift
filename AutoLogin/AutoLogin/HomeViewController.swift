//
//  HomeViewController.swift
//  AutoLogin
//
//  Created by admin on 03.08.15.
//  Copyright (c) 2015 iosDevelopment. All rights reserved.
//

import UIKit
import KeychainAccess

class HomeViewController: UIViewController {

    //MARK: UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.title = "Home"
    }
    
    // MARK: - Log out
    @IBAction func logout(sender: AnyObject) {
        let keychain = Keychain(service: kServiceName)
        keychain.removeAll()
        
        let vc = kStoryboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        let navigationController = UINavigationController(rootViewController: vc)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
