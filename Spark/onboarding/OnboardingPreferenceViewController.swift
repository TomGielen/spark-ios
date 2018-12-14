//
//  OnboardingPreferenceViewController.swift
//  Spark
//
//  Created by issd on 14/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import Foundation
import UIKit

class OnboardingPreferenceViewController: UIViewController {
    
    @IBOutlet weak var malePrefButton: UIButton!
    @IBOutlet weak var femalePrefButton: UIButton!
    
    public var preference : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func MalePrefClick(_ sender: Any) {
        (sender as AnyObject).layer.borderColor = UIColor.sparkGreen.cgColor
        if (preference == "female"){
            femalePrefButton.borderColor = UIColor.backgroundGrey
        }
        preference = "male"
    }
    
    @IBAction func femalePrefClick(_ sender: Any) {
        (sender as AnyObject).layer.borderColor = UIColor.sparkGreen.cgColor
        if (preference == "male"){
            malePrefButton.borderColor  = UIColor.backgroundGrey
        }
        preference = "female"
    }
}
