//
//  OnboardingAgeViewController.swift
//  Spark
//
//  Created by issd on 12/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import UIKit

class OnboardingAgeViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var day: UITextField!
    @IBOutlet weak var month: UITextField!
    @IBOutlet weak var year: UITextField!
    public var editingEnd : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 64, height: view.frame.height + 10))
        titleLabel.text = "SPARK"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(800))
        navigationItem.titleView = titleLabel
        
        day.addShadowToTextField(cornerRadius: 22.5)
        day.addShadowToTextField(color: UIColor.black, cornerRadius: 22.5)
        day.setLeftPaddingPoints(10)
        
        month.addShadowToTextField(cornerRadius: 22.5)
        month.addShadowToTextField(color: UIColor.black, cornerRadius: 22.5)
        month.setLeftPaddingPoints(10)
        
        year.addShadowToTextField(cornerRadius: 22.5)
        year.addShadowToTextField(color: UIColor.black, cornerRadius: 22.5)
        year.setLeftPaddingPoints(10)
        
        day.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        
        if textField === day{
            if (txtAfterUpdate.count == 3){
                     month.becomeFirstResponder()
            }
        }
        if textField === month{
            if (txtAfterUpdate.count == 3){
                year.becomeFirstResponder()
            }
        }
        if textField === year{
            if (txtAfterUpdate.count == 5){
                 self.view.endEditing(true);
                editingEnd = true
                btn.backgroundColor = UIColor.sparkGreen
            }
        }
        return true;
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "ageToGender" {
            if (!editingEnd) {
                return false
            }
        }
        
        let c = NSDateComponents()
        c.day = Int(day.text!)!
        c.month = Int(month.text!)!
        c.year = Int(year.text!)!
        
        let date = NSCalendar(identifier: NSCalendar.Identifier.gregorian)?.date(from: c as DateComponents)
        UserDefaults.standard.set(date, forKey: "dateOfBirth")
        
        return true
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


