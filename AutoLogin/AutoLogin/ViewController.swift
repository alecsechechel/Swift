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
    }
    
    //MARK: - Login
    @IBAction func login(sender: AnyObject) {
        if checkLogin(userTextField.text, password: passwordTextField.text) {
            let keychain = Keychain(service: kServiceName)
            keychain[userTextField.text] = passwordTextField.text
            
            printlnInfo()
            let vc = kStoryboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func printlnInfo() {
        let items = Keychain(service: kServiceName).allItems()
        let user = items[0]["key"] as? String
        let password = items[0]["value"] as? String
        
        println("\(user) - \(password)")
    }
    
    func checkLogin(username: String, password: String ) -> Bool {
        if ((username == kUsernameKey) && (password == kPasswordKey)) {
            return true
        } else {
            showErrorAller()
            return false
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

