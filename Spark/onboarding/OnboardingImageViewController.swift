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
import CoreData

class OnboardingImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var profile_ImageView: UIImageView!
    public var userImage: UIImage? = nil
    public var imageIsCorrect: Bool = false
    

    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: view.frame.height + 10))
        titleLabel.text = "SPARK"
        titleLabel.font = UIFont(name: "Roboto-Bold", size: 20)
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
                       print("level of porn .... ", String(confidence * 100.0))
                       if (confidence * 100.0 > 20){
                         print("level of porn .... yepp this is porn!!")
                        let alertController = UIAlertController(title: "New alert!", message: "User please check out this method", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                        
                       
                        self.presentViewController(alert: alertController, animated: true, completion: nil)
                       } else {
                        self.profile_ImageView.clipsToBounds = true
                        self.profile_ImageView.image = image
                        self.userImage = image
                        self.imageIsCorrect = true
                        self.btn.backgroundColor = UIColor.sparkGreen
                        }
                    }
                }
            } else {
                // Fallback on earlier versions
            }
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    private func presentViewController(alert: UIAlertController, animated flag: Bool, completion: (() -> Void)?) -> Void {
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: flag, completion: completion)
    }
    
    
    @IBAction func registerAccountAndFinishOnboarding(_ sender: Any) {
    
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        let name = UserDefaults.standard.string(forKey: "name")
        let gender = UserDefaults.standard.string(forKey: "gender")
        let preference = UserDefaults.standard.string(forKey: "preference")
        let dateOfBirth = UserDefaults.standard.object(forKey: "dateOfBirth") as! Date
      
        
        var newRegisterUser = RegisterUser()
        newRegisterUser.date_of_birth = dateOfBirth
        newRegisterUser.device_id = deviceID
        newRegisterUser.firstName = name
        newRegisterUser.gender = gender
        newRegisterUser.preference = preference
        newRegisterUser.userImage = "userImage"
        
       
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
                do{
                    let user = try JSONDecoder().decode(RegisterUserResult.self, from: data)
                    print("DE NEIWUE USERRRTT   ", user.result as Any)
                    //
                    self.addUserToCoreData(user: user.result )
                } catch let error {
                    print(error)
                }
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }
    
    //////////////////////////////////////////
    // gaat op deze functie kapot ///////////
    ////////////////////////////////////////
    func addUserToCoreData(user: RegisterUserResponse){
          print(user.date_of_birth)
        
        //var ad: AppDelegate! //or var ad: AppDelegate?
        //var context: NSManagedObjectContext! //or var context: NSManagedObjectContext?
        
        
        DispatchQueue.main.async(execute: {
            
            // Handle further UI related operations here....
            let ad = UIApplication.shared.delegate as! AppDelegate
            let context = ad.managedContext
            
            let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            
            newUser.setValue("rick", forKey: "firstName")
            newUser.setValue(user.lastName, forKey: "lastName")
            newUser.setValue(user.date_of_birth, forKey: "date_of_birth")
            newUser.setValue(user.device_id, forKey: "device_id")
            newUser.setValue(user.gender, forKey: "gender")
            newUser.setValue(user.language, forKey: "language")
            newUser.setValue(user.preference, forKey: "preference")
            newUser.setValue(user.status, forKey: "status")
            newUser.setValue(user.succes_rate, forKey: "succes_rate")
            newUser.setValue(user.userImage, forKey: "UserImage")
            
            do {
                try context.save()
                UserDefaults.standard.set(true, forKey: "FinishedOnboarding")
                self.goToHomeView()
            } catch {
                print("Failed saving")
            }
            
        })
    
    }
    
    func goToHomeView(){
          print("to another page")
        // to onther page
//        let vc = HomeController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}

