//
//  AutoLoginTests.swift
//  AutoLoginTests
//
//  Created by admin on 03.08.15.
//  Copyright (c) 2015 iosDevelopment. All rights reserved.
//

import UIKit
import XCTest
import KeychainAccess

class AutoLoginTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        let keychain = Keychain(service: kServiceName)
        keychain.removeAll()
        
        let navigationController = kStoryboard.instantiateInitialViewController() as! UINavigationController
//        viewController = navigationController.topViewController as! ViewController
        viewController = kStoryboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
        NSRunLoop.mainRunLoop().runUntilDate(NSDate())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccessLoginFunction() {

    }
    
}
