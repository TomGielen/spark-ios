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
    public var userImage: UIImage? = nil
    
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
            userImage = image
            btn.backgroundColor = UIColor.sparkGreen
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func registerAccountAndFinishOnboarding(_ sender: Any) {
    
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        let name = UserDefaults.standard.string(forKey: "name")
        let gender = UserDefaults.standard.string(forKey: "gender")
        let preference = UserDefaults.standard.string(forKey: "preference")
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirth") as! Date
        print("date----------------------",dateOfBirth)
        
        var newRegisterUser = RegisterUser()
        newRegisterUser.date_of_birth = dateOfBirth
        newRegisterUser.device_id = deviceID
        newRegisterUser.firstName = name
        newRegisterUser.gender = gender
        newRegisterUser.preference = preference
        //newRegisterUser.UserImage = userImage
        
        
        // print("flikkers dit is de kanker waarde a neeef " + deviceID!,name!,dateOfBirth as String ,gender!,preference!)
        
        submitPost(registerUser: newRegisterUser) { (error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        
    }
    
    func submitPost(registerUser: RegisterUser, completion:((Error?) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "sparklesapi.azurewebsites.net"
        urlComponents.path = "/user/signup"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        // Now let's encode out Post struct into JSON data...
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(registerUser)
            // ... and set our request's HTTP body
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            completion?(error)
        }
        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError!)
                return
            }
            
            // APIs usually respond with the data you just sent in your POST request
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                
                print("response: ", utf8Representation)
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }
    
    
}

