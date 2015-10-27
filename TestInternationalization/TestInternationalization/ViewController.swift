//
//  ViewController.swift
//  TestInternationalization
//
//  Created by admin on 22.10.15.
//  Copyright © 2015 iosOleksii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = NSLocalizedString("GOOD_MORNING", comment: "")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

