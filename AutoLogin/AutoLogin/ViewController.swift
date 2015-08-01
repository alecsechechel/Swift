//
//  ViewController.swift
//  AutoLogin
//
//  Created by admin on 03.08.15.
//  Copyright (c) 2015 iosDevelopment. All rights reserved.
//

import UIKit
import KeychainAccess

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    
    //MARK: UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let items = Keychain(service: kServiceName).allKeys()
        if !items.isEmpty {
            let vc = kStoryboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    //MARK: - Login
    @IBAction func login(sender: AnyObject) {
        if ((userTextField.text == kUsernameKey) && (passwordTextField.text == kPasswordKey)) {
            let keychain = Keychain(service: kServiceName)
            keychain[userTextField.text] = passwordTextField.text
            
            let vc = kStoryboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            showErrorAller()
        }
    }

    func showErrorAller() {
        var alert = UIAlertView()
        alert.title = "Login Problem"
        alert.message = "Wrong username or password."
        alert.addButtonWithTitle("Try Again!")
        alert.show()
    }
}

