//
//  OnboardingGenderViewController.swift
//  Spark
//
//  Created by issd on 13/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit

class OnboardingGenderViewController: UIViewController {
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    public var gender : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func maleButtonClick(_ sender: Any) {
        (sender as AnyObject).layer.borderColor = UIColor.sparkGreen.cgColor
        if (gender == "female"){
            femaleButton.borderColor = UIColor.backgroundGrey
        }
        gender = "male"
    }
    
    @IBAction func femaleButtonClick(_ sender: Any) {
         (sender as AnyObject).layer.borderColor = UIColor.sparkGreen.cgColor
        if (gender == "male"){
        maleButton.borderColor  = UIColor.backgroundGrey
        }
        gender = "female"
    }
    
    
}
