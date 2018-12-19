//
//  OnboardingImageViewController.swift
//  Spark
//
//  Created by issd on 18/12/2018.
//  Copyright © 2018 Spark Inc. All rights reserved.
//

import Foundation
import UIKit
import NSFWDetector

class OnboardingImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var profile_ImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 64, height: view.frame.height + 10))
        titleLabel.text = "SPARK"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(800))
        navigationItem.titleView = titleLabel
        
        imagePicker.delegate = self
        
        
        profile_ImageView.addTapGestureRecognizer {
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            if #available(iOS 12.0, *) {
                NSFWDetector.shared.check(image: image) { result in
                    switch result {
                    case .error:
                        print("Detection failed")
                    case let .success(nsfwConfidence: confidence):
                       print(String(format: "%.1f %% porn", confidence * 100.0))
                    }
                }
            } else {
                // Fallback on earlier versions
            }
            
            
            profile_ImageView.clipsToBounds = true
            profile_ImageView.image = image
            btn.backgroundColor = UIColor.sparkGreen
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}

