//
//  OnboardingGenderViewController.swift
//  Spark
//
//  Created by issd on 13/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit

class OnboardingGenderViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    public var gender : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: view.frame.height + 10))
        titleLabel.text = "SPARK"
        titleLabel.font = UIFont(name: "Roboto-Bold", size: 20)
        navigationItem.titleView = titleLabel
        
    }
    
    @IBAction func maleButtonClick(_ sender: Any) {
        (sender as AnyObject).layer.borderColor = UIColor.sparkGreen.cgColor
        if (gender == "female"){
            femaleButton.borderColor = UIColor.backgroundGrey
        }
        btn.backgroundColor = UIColor.sparkGreen
        gender = "male"
    }
    
    @IBAction func femaleButtonClick(_ sender: Any) {
         (sender as AnyObject).layer.borderColor = UIColor.sparkGreen.cgColor
        if (gender == "male"){
        maleButton.borderColor  = UIColor.backgroundGrey
        }
        btn.backgroundColor = UIColor.sparkGreen
        gender = "female"
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "genderToPref" {
            if (gender.isEmpty) {
                return false
            }
        }
        
        UserDefaults.standard.set(gender, forKey: "gender")

        
        return true
    }
    
    
}
