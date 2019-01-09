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

class NoSparkCard: UIView {
    //we use lazy properties for each view
    lazy var card: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.cyan.cgColor
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.shadowGrey.cgColor
        view.layer.shadowOpacity = 2
        view.layer.shadowOffset.width = 0
        view.layer.shadowOffset.height = 1
        view.layer.shadowRadius = 4
        view.addSubview(text)
        view.addSubview(searchForRelationBtn)
        return view
    }()
    
    lazy var text: UILabel = {
        let text = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        text.text = "Let's start a new spark."
        return text
    }()
    
    lazy var searchForRelationBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        button.backgroundColor = UIColor.buttonGrey
        button.tintColor = UIColor.black
        button.setTitle("SEARCH FOR A SPARK", for: .normal)
        return button
    }()
    
    
    
    
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //common func to init our view
    private func setupView() {
        backgroundColor = .white
        addSubview(card)
        setupActions()
        
        addConstrainsWithFormat(format: "H:|-32-[v0]-32-|", view: card)
        addConstrainsWithFormat(format: "V:|-8-[v0]-8-|", view: card)
    }
    
    private func setupActions() {
        searchForRelationBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc private func buttonAction(sender: UIButton!) {
        print("ik kan op de button klikken hihihihihihihihihihihihihihihi")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let id = data.value(forKey: "user_id") as? String
                let preference = data.value(forKey: "preference") as? String
                let language = data.value(forKey: "language") as? String
                
                createRelation(id: id!, preference: preference!, language: language!){ (error) in
                    if let error = error {
                        fatalError(error.localizedDescription)
                    }
                }
            }
        } catch {
            print("Failed")
        }
    }
    
    func createRelation(id: String,preference: String, language: String, completion:((Error?) -> Void)?) {
        
        let jsonUrlString = String(format: "https://sparklesapi.azurewebsites.net/matching/search_match/%@/%@/%@", id, preference, language)
        
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let singleObject = try JSONDecoder().decode(matchResponse.self, from: data)
                let json = singleObject.confirmation
                print(json!)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return false
    }
}

let NoSparkCardView = NoSparkCard()
