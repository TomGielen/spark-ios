//
//  OnboardingNameViewController.swift
//  Spark
//
//  Created by issd on 06/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit

class OnboardingNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var NameInputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 64, height: view.frame.height + 10))
        titleLabel.text = "SPARK"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(800))
        navigationItem.titleView = titleLabel
        
        NameInputField.becomeFirstResponder()
        NameInputField.addShadowToTextField(cornerRadius: 22.5)
        NameInputField.addShadowToTextField(color: UIColor.black, cornerRadius: 22.5)
        NameInputField.setLeftPaddingPoints(10)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ((NameInputField.text?.count)! > 1 ){
            self.view.endEditing(true);
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if ((NameInputField.text?.count)! > 1 ){
           textField.resignFirstResponder()
        }
        return true
    }
    
    
    /*
      MARK: - Navigation
     
      In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      Get the new view controller using segue.destination.
      Pass the selected object to the new view controller.
     }
     */
    
}

