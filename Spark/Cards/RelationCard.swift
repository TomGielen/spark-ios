//
//  NoSparkCard.swift
//  Spark
//
//  Created by issd on 08/01/2019.
//  Copyright © 2019 Spark Inc. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import CoreData
import Blurry

class RelationCard: UIView {
    var homeController: UIViewController?
    //we use lazy properties for each view
    lazy var card: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.shadowGrey.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        //        view.layer.shadowColor = UIColor.shadowGrey.cgColor
        //        view.layer.shadowOpacity = 2
        //        view.layer.shadowOffset.width = 0
        //        view.layer.shadowOffset.height = 1
        //        view.layer.shadowRadius = 4
        
        return view
    }()
    
    lazy var UserImage: UIImageView = {
        let view = UIImageView()
        view.layer.borderColor = UIColor.shadowGrey.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true

        return view
    }()
    
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        homeController = HomeController()
        setupView()
        getRelation()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         homeController = HomeController()
        setupView()
        getRelation()
    }
    
    //common func to init our view
    private func setupView() {
        backgroundColor = .white
        addSubview(UserImage)
        setupActions()
        
        ///addConstrainsWithFormat(format: "H:|-32-[v0]-32-|", view: card)
        ///addConstrainsWithFormat(format: "V:|-8-[v0]-8-|", view: card)
        addConstrainsWithFormat(format: "H:|-32-[v0]-32-|", view: UserImage)
        addConstrainsWithFormat(format: "V:|-8-[v0]-8-|", view: UserImage)
    }
    
    private func setupActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        UserImage.isUserInteractionEnabled = true
        UserImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer)
    {
        // if the tapped view is a UIImageView then set it to imageview
        if let imageView = gesture.view as? UIImageView {
            print("Image Tapped")
            //Here you can initiate your new ViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "sparkChatNavController") as! ChatViewController
            //vc.passedRelation = cell.passedRelation
            homeController?.show(vc, sender: nil)
        }
    }
    
    
    
    override class var requiresConstraintBasedLayout: Bool {
        return false
    }
    
    func getRelation(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                if let id = data.value(forKey: "user_id") as? String {
                    let jsonUrlString = String(format: "https://sparklesapi.azurewebsites.net/relation/active_relation/%@", id )
                    
                    guard let url = URL(string: jsonUrlString) else { return }
                    URLSession.shared.dataTask(with: url) { (data, response, err) in
                        guard let data = data else { return }
                        do {
                            let singleObject = try JSONDecoder().decode(ActiveRelation.self, from: data)
                            let json = singleObject
                            print(json)
                            self.getUserImage(firstUser: json.first_user_id, secondUser: json.second_user_id ,userId: id)
                        } catch let jsonErr {
                            print("Error serializing json:", jsonErr)
                        }
                        }.resume()
                }
            }
        } catch {
            print("Failed")
        }
    }
    
    
    func getUserImage(firstUser: ActiveRelationUser, secondUser: ActiveRelationUser ,userId: String){
        if (firstUser._id == userId ){
            setUserImage(image : secondUser.userImage)
        } else {
            setUserImage(image : firstUser.userImage)
        }
    }
    
    func setUserImage(image : String){
        let url = URL(string: image)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    let blurryImage = Blurry.blurryImage(withOptions: BlurryOptions.pro, forImage: UIImage(data: data!)!, size: UIImage(data: data!)!.size, blurRadius: 35.0)

                    self.UserImage.image = blurryImage
                }
            }
            
            }.resume()
    }
}

let RelationCardView = RelationCard()
