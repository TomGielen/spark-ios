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
    @IBOutlet weak var btn: UIButton!
    
    public var preference : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 64, height: view.frame.height + 10))
        titleLabel.text = "SPARK"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(800))
        navigationItem.titleView = titleLabel
        
    }
    
    @IBAction func MalePrefClick(_ sender: Any) {
        (sender as AnyObject).layer.borderColor = UIColor.sparkGreen.cgColor
        if (preference == "female"){
            femalePrefButton.borderColor = UIColor.backgroundGrey
        }
        btn.backgroundColor = UIColor.sparkGreen
        preference = "male"
    }
    
    @IBAction func femalePrefClick(_ sender: Any) {
        (sender as AnyObject).layer.borderColor = UIColor.sparkGreen.cgColor
        if (preference == "male"){
            malePrefButton.borderColor  = UIColor.backgroundGrey
        }
        btn.backgroundColor = UIColor.sparkGreen
        preference = "female"
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "prefToImage" {
            if (preference.isEmpty) {
                return false
            }
        }
        
        UserDefaults.standard.set(preference, forKey: "preference")

        
        return true
    }
}
